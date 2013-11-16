package glb;

public final class GLB[Queue]{Queue<:TaskQueue} {
    private val plh:PlaceLocalHandle[Worker[Queue]];
    
    public def this(init:()=>Queue, n:Int, w:Int, l:Int, z:Int, m:Int) {
        plh = PlaceLocalHandle.makeFlat[Worker[Queue]](PlaceGroup.WORLD, ()=>new Worker[Queue](init, n, w, l, z, m));
    }

    public def taskQueue() = plh().queue;
    
    public def run(start:()=>void) {
        plh().main(plh, start);
    }

    public def stats(verbose:Boolean):Long = Worker.collect[Queue](plh, verbose);
}
