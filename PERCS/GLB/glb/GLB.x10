package glb;

public final class GLB[Queue]{Queue<:TaskQueue[Queue]} {
    private val plh:PlaceLocalHandle[Worker[Queue]];
    
    public def this(init:()=>Queue, n:Int, w:Int, l:Int, z:Int, m:Int, tree:Boolean) {
        plh = PlaceLocalHandle.makeFlat[Worker[Queue]](PlaceGroup.WORLD, ()=>new Worker[Queue](init, n, w, l, z, m, tree));
        Worker.initContexts[Queue](plh);
    }
    
    public def this(init:()=>Queue, glbParams:GLBParameters, tree:Boolean) {
    	plh = PlaceLocalHandle.makeFlat[Worker[Queue]](PlaceGroup.WORLD, 
    			()=>new Worker[Queue](init, glbParams.n, glbParams.w, glbParams.l, glbParams.z, glbParams.m, tree));
    	Worker.initContexts[Queue](plh);
    }
    

    public def taskQueue() = plh().queue;
    
    public def run(start:()=>void) {
        plh().main(plh, start);
    }

    public def runParallel() {
        Worker.broadcast[Queue](plh);
    }

    public def stats(verbose:Boolean):Long = Worker.stats[Queue](plh, verbose);
}
