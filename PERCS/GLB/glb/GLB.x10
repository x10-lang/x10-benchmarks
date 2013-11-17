package glb;

import x10.compiler.*;

public final class GLB[Queue]{Queue<:TaskQueue} {
    private val plh:PlaceLocalHandle[Worker[Queue]];
    
    public def this(init:()=>Queue, n:Int, w:Int, l:Int, z:Int, m:Int, tree:Boolean) {
        plh = PlaceLocalHandle.makeFlat[Worker[Queue]](PlaceGroup.WORLD, ()=>new Worker[Queue](init, n, w, l, z, m, tree));
    }

    public def taskQueue() = plh().queue;
    
    public def run(start:()=>void) {
        @Pragma(Pragma.FINISH_DENSE) finish plh().main(plh, start);
    }

    public def runParallel() {
        @Pragma(Pragma.FINISH_DENSE) finish Worker.broadcast[Queue](plh);
    }

    public def stats(verbose:Boolean):Long = Worker.stats[Queue](plh, verbose);
}
