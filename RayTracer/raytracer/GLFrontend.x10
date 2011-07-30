package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;


import x10.io.File;

import x10.gl.GL;

public class GLFrontend {

    // use a class to get a level of indirection -- this allows to update the actual frame buffer for PBO write
    public static final class GLFrameBuffer extends FrameBuffer {

        var pboFront:Int;
        var pboBack:Int;

        private val width:Int, height:Int, size:Int;

        public def this (width:Int, height:Int, size:Int) {
            super(width, height);

            this.width = width;
            this.height = height;
            this.size = size;

            val ptr = new Array[Int](1);

            GL.glGenBuffers(1, ptr, 0);
            pboFront = ptr(0);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboFront);
            GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0, GL.GL_STREAM_DRAW);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0);

            GL.glGenBuffers(1, ptr, 0);
            pboBack = ptr(0);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboBack);
            GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0, GL.GL_STREAM_DRAW);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0);
        }

        public def update (write:()=>void) {
            // background dma
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboBack);
            GL.glTexSubImage2D(GL.GL_TEXTURE_2D, 0, 0, 0, width, height, GL.GL_RGB, GL.GL_UNSIGNED_BYTE, 0);
            
            
            // update other pbo
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboFront);
            GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0, GL.GL_STREAM_DRAW); // discard
            try {
                raw = GL.glMapBuffer[RGB](GL.GL_PIXEL_UNPACK_BUFFER, GL.GL_WRITE_ONLY, width*height);
                write();
            } finally {
                GL.glUnmapBuffer(GL.GL_PIXEL_UNPACK_BUFFER);
            }
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0);
            
            // swap pbos
            val tmp = pboFront;
            pboFront = pboBack;
            pboBack = tmp;
        }

    }


    val tex : Int;
    val fb : FrameBuffer;


    val rts : PlaceLocalHandle[RayTracer];

    
    val width:Int, height:Int;
    var winWidth:Int, winHeight:Int;

    public def this (opts:OptionsParser, width:Int, height:Int, fb:FrameBuffer, fbr:GlobalRef[FrameBuffer]{home==Place.FIRST_PLACE} ) {

        this.width = this.winWidth = width;
        this.height = this.winHeight = height;
        this.fb = fb;

        val ptr = new Array[Int](1);
        val pixel_format = GL.GL_RGB8;

        GL.glGenTextures(1, ptr, 0);
        tex = ptr(0);
        GL.glBindTexture(GL.GL_TEXTURE_2D, tex);
        GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MIN_FILTER, GL.GL_LINEAR);
        GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MAG_FILTER, GL.GL_LINEAR);
        GL.glTexImage2D[Byte](GL.GL_TEXTURE_2D, 0, pixel_format, width, height, 0, GL.GL_RGB, GL.GL_UNSIGNED_BYTE, null, 0);
        GL.glBindTexture(GL.GL_TEXTURE_2D, 0);

        rts = PlaceLocalHandle.make[RayTracer](Dist.makeUnique(), ()=>new RayTracer(opts, width, height, fbr));

    }

    class FrameEventHandler extends GL.FrameEventHandler {
        public def display () {

            val before = System.nanoTime();

            GL.glBindTexture(GL.GL_TEXTURE_2D, tex);

            fb.update(()=>{
                Team.WORLD.barrier(here.id);
                val before_frame = System.nanoTime();
                rts().renderFrame();
                val after_frame = System.nanoTime();
                val seconds = (after_frame-before_frame)/1E9;
                Console.OUT.println("Render Frame time: " + seconds + "s " + 1/seconds + " FPS.");
                Team.WORLD.barrier(here.id);
            });

            GL.glClear(GL.GL_COLOR_BUFFER_BIT);
            
            GL.glEnable(GL.GL_TEXTURE_2D);
            GL.glBegin(GL.GL_QUADS);
            val edge_u = 0.5f / width;
            val edge_v = 0.5f / width;
            GL.glTexCoord2f(0.0f+edge_u, 1.0f-edge_v);   GL.glVertex3f(-1.0f, -1.0f, 0.0f);
            GL.glTexCoord2f(1.0f-edge_u, 1.0f-edge_v);   GL.glVertex3f( 1.0f, -1.0f, 0.0f);
            GL.glTexCoord2f(1.0f-edge_u, 0.0f+edge_v);   GL.glVertex3f( 1.0f,  1.0f, 0.0f);
            GL.glTexCoord2f(0.0f+edge_u, 0.0f+edge_v);   GL.glVertex3f(-1.0f,  1.0f, 0.0f);
            GL.glEnd();
            GL.glDisable(GL.GL_TEXTURE_2D);

            GL.glBindTexture(GL.GL_TEXTURE_2D, 0);

            GL.glutSwapBuffers();


            val after = System.nanoTime();
            val seconds = (after-before)/1E9;
            Console.OUT.println("Frame time: " + seconds + "s " + 1/seconds + " FPS.");


        }

        public def idle () {
            GL.glutPostRedisplay();
        }

        def setMatrixes ()
        {
            GL.glMatrixMode(GL.GL_PROJECTION);
            GL.glLoadIdentity();
            // letterbox to keep aspect ratio correct
            val aspect = width as Float / height;
            val win_aspect = winWidth as Float / winHeight;
            if (win_aspect > aspect) {
                // window is too wide
                GL.glOrtho(-win_aspect/aspect, win_aspect/aspect, -1, 1, -1, 1);
            } else {
                // window is too tall
                GL.glOrtho(-1, 1, -aspect/win_aspect, aspect/win_aspect, -1, 1);
            }
            

            GL.glMatrixMode(GL.GL_MODELVIEW);
            GL.glLoadIdentity();
        }

        public def reshape (var x:Int, var y:Int) {
            if (x==0) x = 1;
            if (y==0) y = 1;
            winWidth = x;
            winHeight = y;
            GL.glViewport(0, 0, x, y);
            setMatrixes();
        }
    }


    public def run () {
        finish {
            for (p in Place.places()) if (p!=here) async at (p) {
                val rt = rts();
                while (true) {
                    //val before = System.nanoTime();
                    Team.WORLD.barrier(here.id);
                    rt.renderFrame();
                    Team.WORLD.barrier(here.id);
                    //val taken = (System.nanoTime()-before)/1E9/100;
                    //if (!quiet && here == Place.FIRST_PLACE) {
                    //    Console.OUT.println("Frame time: "+taken+"    FPS: "+1/taken);
                    //}
                }
            }
            GL.glutMainLoop(new FrameEventHandler());
        }
    }

    public static def main (args : Array[String]{rail,rank==1,rect}) {here == Place.FIRST_PLACE} {
        try {
            //GL.glutInit(args);
            val opts = new OptionsParser(args, [
                Option("q","quiet","print out less"),
                Option("v","verbose","print out more"),
                Option("?","help","this information")
            ], [
                Option("W","width","width of rendered output"),
                Option("H","height","height of rendered output"),
                Option("w","horz-splits","number of times to split width-ways"),
                Option("h","vert-splits","number of times to split height-ways")
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
            val size = global_width * global_height * 3;


            GL.glutInit(args);
            GL.glutInitDisplayMode(GL.GLUT_RGB | GL.GLUT_DOUBLE); // double buffered
            GL.glutCreateWindow("X10 Distributed Raytracer");
            GL.glewInit();

            val fb = new GLFrameBuffer(global_width, global_height, size);
            val fbr = new GlobalRef[FrameBuffer](fb);

            val fe = new GLFrontend(opts, global_width, global_height, fb, fbr);

            fe.run();


        } catch (e:Throwable) { e.printStackTrace(); }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

