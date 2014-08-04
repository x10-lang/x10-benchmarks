package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;
import x10.io.File;
import x10.gl.GL;

public class GLFrontend {

    // use a class to get a level of indirection -- this allows to update the actual frame buffer for PBO write
    public static final class GLFrameBuffer extends FrameBuffer {

        var pboFront:Int;
        var pboBack:Int;

        var h:Int = 0n;

        private val width:Int, height:Int, size:Int;

        public def this(width:Int, height:Int, size:Int) {
            super(width, height);

            this.width = width;
            this.height = height;
            this.size = size;

            val ptr = new Rail[Int](1);

            GL.glGenBuffers(1n, ptr, 0n);
            pboFront = ptr(0);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboFront);
            GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0n, GL.GL_STREAM_DRAW);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0n);

            GL.glGenBuffers(1n, ptr, 0n);
            pboBack = ptr(0);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboBack);
            GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0n, GL.GL_STREAM_DRAW);
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0n);
        }

        public def update(write:()=>void) {
            // background dma
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboBack);
// FIXME : uncomment and fix caller in GL.x10.
//            GL.glTexSubImage2D(GL.GL_TEXTURE_2D, 0n, 0n, 0n, width, height, GL.GL_RGB, GL.GL_UNSIGNED_BYTE, 0n);
            
            
            // update other pbo
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, pboFront);
            GL.glBufferData[Byte](GL.GL_PIXEL_UNPACK_BUFFER, size, null, 0n, GL.GL_STREAM_DRAW); // discard
            try {
// FIXME : fix caller in GL.x10.
//                raw = GL.glMapBuffer[RGB](GL.GL_PIXEL_UNPACK_BUFFER, GL.GL_WRITE_ONLY, width*height);
                /*
                for (y in 0..(height-1)) {
                    for (x in 0..(width-1)) {
                        val c1 = ((x*x) / 256 + 3 * y + h*10) as UByte;
                        val c2 = ((y*y) / 256 + x + h*10) as UByte;
                        val c3 = ((y*y + x*x) / 256 + h*10) as UByte;
                        raw(y*width + x) = RGB(c1, c2, c3);
                    }
                }
                h++;
                */
                write();
            } finally {
                GL.glUnmapBuffer(GL.GL_PIXEL_UNPACK_BUFFER);
            }
            GL.glBindBuffer(GL.GL_PIXEL_UNPACK_BUFFER, 0n);
            
            // swap pbos
            val tmp = pboFront;
            pboFront = pboBack;
            pboBack = tmp;
        }

    }


    val tex:Int;
    val fb:FrameBuffer;
    val rts:PlaceLocalHandle[Engine];
    
    val width:Int, height:Int;
    var winWidth:Int, winHeight:Int;

    val keyDown = new Rail[Boolean](256);
    var currMouseX:Int;
    var currMouseY:Int;
    var lastMouseX:Int;
    var lastMouseY:Int;
    var mouseDown:Boolean;
    var fastDown:Boolean;
    var pos:Vector3;
    var yaw:Float;
    var pitch:Float;
    var lastFrameTime:Long = System.nanoTime();

    public def orientation() = Quat.angleAxis(yaw/180 * (Math.PI as Float),0,0,-1)
                             * Quat.angleAxis(pitch/180 * (Math.PI as Float),1,0,0);

    public def updatePosOrientation() {
        val thisFrameTime = System.nanoTime();
        val elapsed = (thisFrameTime - lastFrameTime)/1E9f;
        lastFrameTime = thisFrameTime;
        val mouse_move_x = currMouseX - lastMouseX;
        val mouse_move_y = currMouseY - lastMouseY;
        currMouseX = GL.glutGet(GL.GLUT_WINDOW_WIDTH)/2n;
        currMouseY = GL.glutGet(GL.GLUT_WINDOW_HEIGHT)/2n;
        lastMouseX = currMouseX;
        lastMouseY = currMouseY;
        if (mouseDown)
            GL.glutWarpPointer(currMouseX, currMouseY);

        val turn_speed = 50.0f;
        val rot_right = (keyDown('3'.ord()) ? 1.0f : 0.0f) - (keyDown('1'.ord()) ? 1.0f : 0.0f);
        val rot_up = (keyDown('2'.ord()) ? 1.0f : 0.0f) - (keyDown('5'.ord()) ? 1.0f : 0.0f);
        yaw += mouse_move_x * 0.2f;
        pitch += mouse_move_y * 0.2f;
        yaw += elapsed * turn_speed * rot_right;
        pitch += elapsed * turn_speed * rot_up;
        pitch = Math.min(Math.max(pitch, -90.0f), 90.0f);

        val move_speed = fastDown ? 15.0f : 3.0f;
        val forwards = (keyDown('w'.ord()) ? 1.0f : 0.0f) - (keyDown('s'.ord()) ? 1.0f : 0.0f);
        val right = (keyDown('d'.ord()) ? 1.0f : 0.0f) - (keyDown('a'.ord()) ? 1.0f : 0.0f);
        val up = (keyDown(' '.ord()) ? 1.0f : 0.0f) - (keyDown('c'.ord()) ? 1.0f : 0.0f);
        val pos_change = forwards * elapsed * move_speed * (orientation()*Vector3(0,1,0))
                       + right * elapsed * move_speed * (orientation()*Vector3(1,0,0))
                       + up * elapsed * move_speed * Vector3(0,0,1);
        pos += pos_change;
    }

    val startTime:Long;

    public def this(opts:OptionsParser, width:Int, height:Int, fb:FrameBuffer, sl:SceneLoader) {

        this.startTime = System.nanoTime();
        this.width = this.winWidth = width;
        this.height = this.winHeight = height;
        this.fb = fb;

        val ptr = new Rail[Int](1);
        val pixel_format = GL.GL_RGB8;

        GL.glGenTextures(1n, ptr, 0n);
        this.tex = ptr(0);
        GL.glBindTexture(GL.GL_TEXTURE_2D, tex);
        GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MIN_FILTER, GL.GL_LINEAR);
        GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MAG_FILTER, GL.GL_LINEAR);
        GL.glTexImage2D[Byte](GL.GL_TEXTURE_2D, 0n, pixel_format, width, height, 0n, GL.GL_RGB, GL.GL_UNSIGNED_BYTE, null, 0n);
        GL.glBindTexture(GL.GL_TEXTURE_2D, 0n);

        val prims = sl.prims.toRail();
        val vertexes = sl.vertexes.toRail();
        val skybox = sl.skybox;

        this.pos = sl.camPos;
        this.yaw = sl.camYaw;
        this.pitch = sl.camPitch;

        this.rts = PlaceLocalHandle.make[Engine](Place.places(), ()=>new Engine(opts, width, height, prims, vertexes, skybox));
    }

    class FrameEventHandler extends GL.FrameEventHandler {

        public def display() {

            val before = System.nanoTime();

            GL.glBindTexture(GL.GL_TEXTURE_2D, tex);

            fb.update(()=>{
                val pos_ = pos;
                updatePosOrientation();
                val orientation_ = orientation();
// FIXME fb.raw() could be null?
                val raw_ = new GlobalRail[RGB](fb.raw() as Rail[RGB]{self!=null});
                val rts_ = rts;
                val time = (before - startTime) / 1.0E9f;
                val denting_water = keyDown('f'.ord());
                finish for (p in Place.places()) async at (p) {
                    rts_().renderFrame(raw_, denting_water, pos_, orientation_, time);
                }
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

            GL.glBindTexture(GL.GL_TEXTURE_2D, 0n);

            GL.glutSwapBuffers();

            val after = System.nanoTime();
            val seconds = (after-before)/1E9;
            Console.OUT.println("Frame time: " + seconds + "s " + 1/seconds + " FPS.");
        }

        public def idle() {
            GL.glutPostRedisplay();
        }

        def setMatrixes() {

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

        public def reshape(var x:Int, var y:Int) {
            if (x==0n) x = 1n;
            if (y==0n) y = 1n;
            winWidth = x;
            winHeight = y;
            GL.glViewport(0n, 0n, x, y);
            setMatrixes();
        }

        public def motion(x:Int, y:Int):void {
            if (mouseDown) {
                currMouseX = x;
                currMouseY = y;
            }
        }

        public def mouse(button:Int, state:Int, x:Int, y:Int) {
            if (button==0n) {
                if (state==0n) {
                    lastMouseX = x;
                    lastMouseY = y;
                    currMouseX = x;
                    currMouseY = y;
                    mouseDown = true;
                    GL.glutSetCursor(GL.GLUT_CURSOR_NONE);
                } else {
                    mouseDown = false;
                    GL.glutSetCursor(GL.GLUT_CURSOR_INHERIT);
                }
            } else if (button==2n) {
                if (state==0n) {
                    fastDown = true;
                } else {
                    fastDown = false;
                }
            }
        }

        public def keyboardUp(key_:Char, x:Int, y:Int) {
            val key = key_.toLowerCase();
            keyDown(key.ord()) = false;
        }

        public def keyboard(key_:Char, x:Int, y:Int) {
            val key = key_.toLowerCase();
            keyDown(key.ord()) = true;
        }
    }


    public def run() {
        finish {
            GL.glutMainLoop(new FrameEventHandler());
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
            val global_width = opts("-W",320n);
            val global_height = opts("-H",240n);
            val size = global_width * global_height * 3n;


            GL.glutInit(args);
            GL.glutInitDisplayMode(GL.GLUT_RGB | GL.GLUT_DOUBLE); // double buffered
            GL.glutCreateWindow("X10 Distributed Raytracer");
            GL.glewInit();

            val sl = new SceneLoader();
            
            for (s in opts.filteredArgs()) {
                sl.loadScene(s);
            }

            val fb = new GLFrameBuffer(global_width, global_height, size);
            val fe = new GLFrontend(opts, global_width, global_height, fb, sl);

            fe.run();

        } catch (e:CheckedThrowable) { e.printStackTrace(); }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
