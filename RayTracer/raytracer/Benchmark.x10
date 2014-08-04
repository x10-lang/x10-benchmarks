package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;


import x10.io.File;

public class Benchmark {

    public static final class DummyFrameBuffer extends FrameBuffer {
        public def this(width:Int, height:Int) {
            super(width, height);
        }
        public def update(write:()=>void) {
            write();
        }
    }

    public static def main(args:Rail[String]) {
        try {
            val opts = new OptionsParser(args, [
                Option("q","quiet","print out less"),
                Option("v","verbose","print out more"),
                Option("o","dump","dump the octree of the scene"),
                Option("?","help","this information"),
                Option("O","octree","use an octree"),
                Option("l","loose","use a loose octree")
            ], [
                Option("W","width","width of rendered output"),
                Option("H","height","height of rendered output"),
                Option("w","horz-splits","number of times to split width-ways"),
                Option("h","vert-splits","number of times to split height-ways"),
                Option("x","horz-blocks","number of times to split width-ways within a place"),
                Option("y","vert-blocks","number of times to split height-ways within a place"),
                Option("b","mipmap-bias","skip this many mipmap levels"),
                Option("d","octree-depth","bottom out the octree at this depth"),
                Option("f","dump-file","dump file for the octree of the scene"),
                Option("i","iteration","iteration count")
            ]);
            if (opts("-?")) {
                opts.showHELP();
                return;
            }

            val verbose = opts("-v");
            val quiet = opts("-q");
            val global_width = opts("-W",800n);
            val global_height = opts("-H",600n);
            val output = opts("-o");
            val output_file = opts("-f","output.raw");

            val sl = new SceneLoader();
            
            for (s in opts.filteredArgs()) {
                sl.loadScene(s);
            }

            val prims = sl.prims.toRail();
            val vertexes = sl.vertexes.toRail();
            val skybox = sl.skybox;

            val pos = sl.camPos;
            val yaw = sl.camYaw;
            val pitch = sl.camPitch;
            val orientation = Quat.angleAxis(yaw/180 * (Math.PI as Float),0,0,-1)
                            * Quat.angleAxis(pitch/180 * (Math.PI as Float),1,0,0);

            val fb = new DummyFrameBuffer(global_width, global_height);
// FIXME fbr not used?
            val fbr = new GlobalRef[FrameBuffer](fb);
                    
            val rts = PlaceLocalHandle.make[Engine](Place.places(), ()=>new Engine(opts, global_width, global_height, prims, vertexes, skybox));
            val iters = opts("-i",100n);

            val before_all = System.nanoTime();
// FIXME fb.raw() could be null?
            val raw_ = new GlobalRail[RGB](fb.raw() as Rail[RGB]{self!=null});

            finish for (p in Place.places()) async at (p) {
                val rt = rts();

                for (iteration in 1..iters) {
                    Team.WORLD.barrier();
                    val before = System.nanoTime();
                    val time = (before-before_all)/1.0E9f;
                    rt.renderFrame(raw_, false/*denting_water*/, pos, orientation, time);
                    Team.WORLD.barrier();
                    if (!quiet && here.id == 0) {
                        val taken = (System.nanoTime()-before)/1E9;
                        Console.OUT.println("Frame time: "+taken+"    FPS: "+1/taken);
                    }
                }
            }

            if (output) {
                // write to disk
                val f = new File(output_file);
                val fw = f.openWrite();
                for (i in 0n..(fb.length()-1) as Int) {
                    fw.write(fb(i).r as Byte);
                    fw.write(fb(i).g as Byte);
                    fw.write(fb(i).b as Byte);
                }
                fw.close();
            }

        } catch (e:CheckedThrowable) { e.printStackTrace(); }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
