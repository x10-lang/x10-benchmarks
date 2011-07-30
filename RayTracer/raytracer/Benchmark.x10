package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;


import x10.io.File;

public class Benchmark {

    public static final class DummyFrameBuffer extends FrameBuffer {

        public def this (width:Int, height:Int) {
            super(width, height);
        }
        
        public def update (write:()=>void) {
            write();
        }

    }



    public static def main (args : Array[String](1)) {here == Place.FIRST_PLACE} {
        try {
            val opts = new OptionsParser(args, [
                Option("q","quiet","print out less"),
                Option("v","verbose","print out more"),
                Option("?","help","this information"),
                Option("o","output","output the final frame (raw format)")
            ], [
                Option("W","width","width of rendered output"),
                Option("H","height","height of rendered output"),
                Option("w","horz-splits","number of times to split width-ways"),
                Option("h","vert-splits","number of times to split height-ways"),
                Option("i","iterations","iterations"),
                Option("f","output-file","filename to use to output final frame")
            ]);
            if (opts.filteredArgs().size!=0) {
                Console.ERR.println("Unexpected arguments: "+opts.filteredArgs());
                Console.ERR.println("Use -? or --help.");
                System.setExitCode(1);
                return;
            }
            if (opts("-?")) {
                Console.OUT.println(opts.usage());
                return;
            }

            val verbose = opts("-v");
            val quiet = opts("-q");
            val global_width = opts("-W",800);
            val global_height = opts("-H",600);
            val output = opts("-o");
            val output_file = opts("-f","output.raw");

            val fb = new DummyFrameBuffer(global_width, global_height);
            val fbr = new GlobalRef[FrameBuffer](fb);
                    
            val rts = PlaceLocalHandle.make[RayTracer](Dist.makeUnique(), ()=>new RayTracer(opts, global_width, global_height, fbr));
            val iters = opts("-i",100);

            finish for (p in Place.places()) async at (p) {
                val rt = rts();

                for ([iteration] in 1..iters) {
                    Team.WORLD.barrier(here.id);
                    val before = System.nanoTime();
                    rt.renderFrame();
                    Team.WORLD.barrier(here.id);
                    val taken = (System.nanoTime()-before)/1E9;
                    if (!quiet && here == Place.FIRST_PLACE) {
                        Console.OUT.println("Frame time: "+taken+"    FPS: "+1/taken);
                    }
                }
            }

            if (output) {
                // write to disk
                val f = new File(output_file);
                val fw = f.openWrite();
                for ([i] in 0..(fb.length() - 1)) {
                    fw.write(fb(i).r as Byte);
                    fw.write(fb(i).g as Byte);
                    fw.write(fb(i).b as Byte);
                }
                fw.close();

            }

        } catch (e:Throwable) { e.printStackTrace(); }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

