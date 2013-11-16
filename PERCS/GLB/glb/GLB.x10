package glb;

public final class GLB {
    private val plh:PlaceLocalHandle[Worker];
    
    public def this(init:()=>TaskQueue, n:Int, w:Int, l:Int, z:Int, m:Int) {
        plh = PlaceLocalHandle.makeFlat[Worker](PlaceGroup.WORLD, ()=>new Worker(init, n, w, l, z, m));
    }

    public def taskQueue() = plh().queue;
    
    public def run(start:()=>void) {
        plh().main(plh, start);
    }

    public def stats(verbose:Boolean):Long = Worker.collect(plh, verbose);
}
