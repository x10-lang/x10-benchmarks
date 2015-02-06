import x10.util.Random;
import x10.xrx.Runtime;

public final class BlockedArray implements (Int,Int)=>Double {
    public final static class Block implements (Int,Int)=>Double {
        public val min_x:Int;
        public val min_y:Int;
        public val max_x:Int;
        public val max_y:Int;
        private val delta:Int;
        private val offset:Int;
        public val raw:Rail[Double];
    
        public def this(I:Int, J:Int, bx:Int, by:Int, rand:Random) {
            min_x = I*bx;
            min_y = J*by;
            max_x = (I+1n)*bx-1n;
            max_y = (J+1n)*by-1n;
            delta = by;
            offset = (I*bx+J)*by;
            val allocator = Runtime.MemoryAllocator.requestAllocator(true, false);
            val raw = new Rail[Double](bx*by, allocator);
            for(var i:Int = 0n; i < bx*by; i++) raw(i) = rand.nextDouble()*10;
            this.raw = raw;
        }
    
        public operator this(i:Int, j:Int) = (v:Double) {
            raw(i*delta+j-offset) = v;
        }
    
        public operator this(i:Int, j:Int) = raw(i*delta+j-offset);
    }

    public static struct ArrayView {
        public val min_x:Int;
        public val min_y:Int;
        public val max_x:Int;
        public val max_y:Int;
        private val array:BlockedArray;

        public def this(min_x:Int, min_y:Int, max_x:Int, max_y:Int, array:BlockedArray) {
            this.min_x = min_x;
            this.min_y = min_y;
            this.max_x = max_x;
            this.max_y = max_y;
            this.array = array;
        }

        public def block(I:Int, J:Int) = array.block(I, J);
        public def blockOf(i:Int, j:Int) = array.blockOf(i, j);
        public operator this(i:Int, j:Int) = array(i, j);
        public def empty() = array == null;
    }

    private val bx:Int;
    private val by:Int;
    private val px:Int;
    private val py:Int; 
    private val min_x:Int;
    private val min_y:Int;
    private val ny:Int;
    private val data:Rail[Block];

    public def this(M:Int, N:Int, bx:Int, by:Int, px:Int, py:Int) {
        this.bx = bx;
        this.by = by;
        this.px = px;
        this.py = py;
        val min_x = (here.id as Int)%px;
        val min_y = (here.id as Int)/px;
        val nx = M/(bx*px);
        val ny = (N-by)/(by*py)+(min_y==0n ? 1n : 0n);
        this.min_x = min_x;
        this.min_y = min_y;
        this.ny = ny;
        val rand = new Random((here.id as Int)*1000n);
        data = new Rail[Block](nx*ny, (k:Long)=>new Block((k as Int)/ny*px+min_x, (k as Int)%ny*py+min_y, bx, by, rand));
    }

    public operator this(i:Int, j:Int)
        = blockOf(i, j)(i, j);
    public operator this(i:Int, j:Int) = 
        (v:Double){ blockOf(i, j)(i, j) = v; }

    public def block(I:Int, J:Int) = data((I-min_x)/px*ny+(J-min_y)/py);
    public def blockOf(i:Int, j:Int) = block(i/bx, j/by);
    public def placeOf(i:Int, j:Int) = placeOfBlock(i/bx, j/by);
    public def hasBlock(I:Int, J:Int) = placeOfBlock(I, J) == (here.id as Int);
    public def hasCol(J:Int) = (here.id as Int)/px == J%py;
    public def hasRow(I:Int) = (here.id as Int)%px == I%px;
    public def placeOfBlock(I:Int, J:Int) = I%px+J%py*px;

    public def blocks(min_x:Int, max_x:Int, min_y:Int, max_y:Int) {
        val view_min_x = min_x+(px+this.min_x-(min_x%px))%px;
        val view_min_y = min_y+(py+this.min_y-(min_y%py))%py;
        val view_max_x = max_x-(px+(max_x%px)-this.min_x)%px;
        val view_max_y = max_y-(py+(max_y%py)-this.min_y)%py;
        val b = (view_max_x < view_min_x || view_max_y < view_min_y) ? null : this;
        return ArrayView(view_min_x, view_min_y, view_max_x, view_max_y, b);
    }

    // inputs are global coordinates
    public def getRow(row:Int, min_y:Int, max_y:Int, rail:Rail[Double]) {
        val brow = row/bx;
        val view = blocks(brow, brow, min_y/by, max_y/by);
        var n:Int = 0n;
        for (var J:Int = view.min_y; J <= view.max_y; J += py) {
            val b = view.block(view.min_x, J);
            for (var j:Int = Math.max(min_y, b.min_y); j <= Math.min(max_y, b.max_y); j++) {
                rail(n++) = b(row, j);
            }
        }
        return n;
    }

    public def setRow(row:Int, min_y:Int, max_y:Int, rail:Rail[Double]) {
        val brow = row / bx;
        val view = blocks(brow, brow, min_y/by, max_y/by);
        var n:Int = 0n;
        for (var J:Int = view.min_y; J <= view.max_y; J += py) {
            val b = view.block(view.min_x, J);
            for (var j:Int = Math.max(min_y, b.min_y); j <= Math.min(max_y, b.max_y); j++) {
                b(row, j) = rail(n++);
            }
        }
    }

    public def swapRow(row:Int, min_y:Int, max_y:Int, rail:Rail[Double]) {
        val brow = row / bx;
        val view = blocks(brow, brow, min_y/by, max_y/by);
        var n:Int = 0n;
        for (var J:Int = view.min_y; J <= view.max_y; J += py) {
            val b = view.block(view.min_x, J);
            for (var j:Int = Math.max(min_y, b.min_y); j <= Math.min(max_y, b.max_y); j++) {
                val v = b(row, j);
                b(row, j) = rail(n);
                rail(n++) = v;
            }
        }
        return n;
    }

    public static def make(M:Int, N:Int, bx:Int, by:Int, px:Int, py:Int) {
        return PlaceLocalHandle.makeFlat[BlockedArray](Place.places(),
            ()=>new BlockedArray(M, N, bx, by, px ,py));
    }
}
