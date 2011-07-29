package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;

import x10.io.File;

import x10.gl.GL;

public class GLFrontend {

    val pboFront = new Array[Int](1);
    val pboBack = new Array[Int](1);
    val tex = new Array[Int](1);
    val mappedBuffer : Array[RGB]{rank==1,rail,rect};
    val mappedBufferRemote : RemoteArray[RGB]{rank==1,home==Place.FIRST_PLACE};

    val width:Int, height:Int, size:Int;

    val rts : PlaceLocalHandle[RayTracer];

    var winWidth:Int, winHeight:Int;

    public def this (opts:OptionsParser, width:Int, height:Int, mappedBuffer : Array[RGB]{rank==1,rail,rect}, mappedBufferRemote : RemoteArray[RGB]{rank==1,home==Place.FIRST_PLACE} ) {

        this.width = this.winWidth = width;
        this.height = this.winHeight = height;

        this.size = width * height * 3;
        val pixel_format = GL.GL_RGB8;

        GL.glutInitDisplayMode(GL.GLUT_RGB | GL.GLUT_DOUBLE); // double buffered

        GL.glutInitWindowSize(width, height);

        GL.glutCreateWindow("X10 Distributed Raytracer");

        GL.glewInit();

        GL.glGenTextures(1, tex, 0);
        GL.glBindTexture(GL.GL_TEXTURE_2D, tex(0));
        GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MIN_FILTER, GL.GL_LINEAR);
        GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MAG_FILTER, GL.GL_LINEAR);
        GL.glTexImage2D[Byte](GL.GL_TEXTURE_2D, 0, pixel_format, width, height, 0, GL.GL_RGB, GL.GL_UNSIGNED_BYTE, null, 0);
        GL.glBindTexture(GL.GL_TEXTURE_2D, 0);

        GL.glGenBuffers(1, pboFront, 0);
        GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboFront(0));
        GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0, GL.GL_STREAM_DRAW);
        GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0);

        GL.glGenBuffers(1, pboBack, 0);
        GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboBack(0));
        GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0, GL.GL_STREAM_DRAW);
        GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0);

        this.mappedBuffer = mappedBuffer;
        this.mappedBufferRemote = mappedBufferRemote;

        val first_rt = new RayTracer(opts, width, height, mappedBufferRemote);
        rts = PlaceLocalHandle.make[RayTracer](Dist.makeUnique(), ()=>first_rt);

    }

    class FrameEventHandler extends GL.FrameEventHandler {
        public def display () {

            val before = System.nanoTime();

            GL.glBindTexture(GL.GL_TEXTURE_2D, tex(0));

            // background dma
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboBack(0));
            GL.glTexSubImage2D(GL.GL_TEXTURE_2D, 0, 0, 0, width, height, GL.GL_RGB, GL.GL_UNSIGNED_BYTE, 0);
            
            
            // update other pbo
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboFront(0));
            GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0, GL.GL_STREAM_DRAW); // discard
            GL.glMapBuffer(GL.GL_PIXEL_UNPACK_BUFFER, GL.GL_WRITE_ONLY, mappedBuffer);
            Team.WORLD.barrier(here.id);
            rts().renderFrame();
            Team.WORLD.barrier(here.id);
            GL.glUnmapBuffer(GL.GL_PIXEL_UNPACK_BUFFER);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0);
            
            // swap pbos
            val tmp = pboFront(0);
            pboFront(0) = pboBack(0);
            pboBack(0) = tmp;

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
            GL.glutInit(args);
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

            val buf = new Array[RGB](global_width*global_height);
            val buf_remote = new RemoteArray[RGB](buf);
            val fe = new GLFrontend(opts, global_width, global_height, buf, buf_remote);

            fe.run();

        } catch (e:Throwable) { e.printStackTrace(); }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab

