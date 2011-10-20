package raytracer;

import x10.io.Console;
import x10.util.OptionsParser;
import x10.util.Option;
import x10.util.Team;
import x10.util.Pair;
import x10.util.IndexedMemoryChunk;
import x10.util.RemoteIndexedMemoryChunk;
import x10.util.HashMap;

import x10.io.*;

import raytracer.primitives.*;

import x10.compiler.Inline;

public class RayTracer {

    globalWidth:Int;
    globalHeight:Int;
    localWidth:Int;
    localHeight:Int;
    horzSplits:Int;
    vertSplits:Int;
    frameBuffer:GlobalRef[FrameBuffer]{home==Place.FIRST_PLACE};
    localFrame:Array[RGB](1){self!=null};
    verbose:Boolean;
    quiet:Boolean;
    filename:String;
    dumpOctree:Boolean;

    var orientation:Quat = Quat(1,0,0,0);
    var pos:Vector3 = Vector3(0,0,0);

    val matTable = new HashMap[String, Material]();

    public def this (opts:OptionsParser, global_width:Int, global_height:Int,
                     frameBuffer:GlobalRef[FrameBuffer]{home==Place.FIRST_PLACE}) {

        verbose = opts("-v");
        quiet = opts("-q");

        dumpOctree = opts("-o");

        globalWidth = global_width;
        globalHeight = global_height;

        var horz_splits:Int = 1;
        switch (Place.MAX_PLACES) {
            case 1: horz_splits = 1; break;
            case 2: horz_splits = 2; break;
            case 3: horz_splits = 3; break;
            case 4: horz_splits = 2; break;
            case 6: horz_splits = 3; break;
            case 8: horz_splits = 4; break;
            case 9: horz_splits = 3; break;
            case 10: horz_splits = 5; break;
            default:
        }
        horzSplits = opts("-w",horz_splits);
        vertSplits = opts("-h",Place.MAX_PLACES / horz_splits);
        if (horzSplits * vertSplits != Place.MAX_PLACES) {
            throw new Error("Number of places not appropriate for given horizontal / vertical splits");
        }

        localWidth = global_width / horzSplits;
        localHeight = global_height / vertSplits;

        if (!quiet) {
            Console.OUT.println("horzSplits: "+horzSplits);
            Console.OUT.println("vertSplits: "+vertSplits);
            Console.OUT.println("localWidth: "+localWidth);
            Console.OUT.println("localHeight: "+localHeight);
        }

        filename = opts.filteredArgs()(0);

        this.frameBuffer = frameBuffer;
        localFrame = new Array[RGB](localWidth * localHeight);
    }

    val sunDir = Vector3(0,0,1);
    val ambLight = 0.15f;
    val diffLightCol = Vector3(1,1,1);

    public final def lightingEquation(diff_surf_col:Vector3, amb_surf_col:Vector3, normal:Vector3, pos:Vector3) {
            val the_dot = normal.dot(sunDir); 

            // half lambert shading 
            val diff_exp = (the_dot * 0.5f + 0.5f) * (the_dot * 0.5f + 0.5f); 
            // standard shading 
            //val diff_exp = Math.max(0.0f, the_dot); 

            val amb_comp  =            ambLight     * amb_surf_col;
            val diff_comp = diff_exp * diffLightCol * diff_surf_col;
            //val spec_comp = spec_exp * specLightCol * scol;

            // sum up all the various components
            return (amb_comp + diff_comp) as RGB;
    }


    public static class SolidColour(col:RGB) extends Material {
        public def render (rt:RayTracer, s:RayState) : RGB = rt.lightingEquation(col as Vector3, col as Vector3, s.normal, s.o + s.t*s.d);
    }

    public static class Textured(tex:Texture2D) extends Material {
        public def render (rt:RayTracer, s:RayState) : RGB {
            val col = tex(s.texCoord.first, s.texCoord.second, 0);
            return rt.lightingEquation(col, col, s.normal, s.o + s.t*s.d);
        }
    }

    val scene = new Octree(12, AABB(Vector3(-100,-100,-100),Vector3(100,100,100)));
    public def init() {

        val tex = new Texture2D(256,256);
        tex.init((x_:Int, y_:Int)=> {
            val x = (x_-128) / 128.0f;
            val y = (y_-128) / 128.0f;
            return (x*x + y*y > 1) ? RGB.BLACK : RGB.RED;
        }); 

        val white = new SolidColour(RGB.WHITE);
        matTable.put("WHITE", white);
        matTable.put("GREY", new SolidColour(RGB.GREY));
        matTable.put("BLACK", new SolidColour(RGB.BLACK));
        matTable.put("RED", new SolidColour(RGB.RED));
        matTable.put("DARK_RED", new SolidColour(RGB.DARK_RED));
        matTable.put("GREEN", new SolidColour(RGB.GREEN));
        matTable.put("DARK_GREEN", new SolidColour(RGB.DARK_GREEN));
        matTable.put("BLUE", new SolidColour(RGB.BLUE));
        matTable.put("DARK_BLUE", new SolidColour(RGB.DARK_BLUE));
        matTable.put("CIRCLE", new Textured(tex));


        val file = new File(filename);
        for (line_ in file.lines()) {
            val line = line_.trim();
            val splits = line.split("#")(0).split(" ");
            if (splits.size == 0) continue;
            if (splits(0).equalsIgnoreCase("SPHERE")) {
                if (splits.size == 6) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));
                    val r = Float.parse(splits(4));
                    val m = matTable.getOrElse(splits(5),white);
                    scene.insert(new Sphere(Vector3(x,y,z),r,m));
                } else if (here == Place.FIRST_PLACE) {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("SPECKLEDSPHERE")) {
                if (splits.size == 6) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));
                    val r = Float.parse(splits(4));
                    val m = matTable.getOrElse(splits(5),white);
                    scene.insert(new Sphere(Vector3(x,y,z),r,m));
                } else if (here == Place.FIRST_PLACE) {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("TRI")) {
                if (splits.size == 11) {
                    val x1 = Float.parse(splits(0+1));
                    val y1 = Float.parse(splits(0+2));
                    val z1 = Float.parse(splits(0+3));
                    val x2 = Float.parse(splits(3+1));
                    val y2 = Float.parse(splits(3+2));
                    val z2 = Float.parse(splits(3+3));
                    val x3 = Float.parse(splits(6+1));
                    val y3 = Float.parse(splits(6+2));
                    val z3 = Float.parse(splits(6+3));
                    val m = matTable.getOrElse(splits(10),white);
                    scene.insert(new Triangle(Vector3(x1,y1,z1),Vector3(x2,y2,z2),Vector3(x3,y3,z3),m));
                } else if (here == Place.FIRST_PLACE) {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("DTRI")) {
                if (splits.size == 11) {
                    val x1 = Float.parse(splits(0+1));
                    val y1 = Float.parse(splits(0+2));
                    val z1 = Float.parse(splits(0+3));
                    val x2 = Float.parse(splits(3+1));
                    val y2 = Float.parse(splits(3+2));
                    val z2 = Float.parse(splits(3+3));
                    val x3 = Float.parse(splits(6+1));
                    val y3 = Float.parse(splits(6+2));
                    val z3 = Float.parse(splits(6+3));
                    val m = matTable.getOrElse(splits(10),white);
                    scene.insert(new DoubleTriangle(Vector3(x1,y1,z1),Vector3(x2,y2,z2),Vector3(x3,y3,z3),m));
                } else if (here == Place.FIRST_PLACE) {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("UVTRI")) {
                if (splits.size == 17) {
                    val x1 = Float.parse(splits(0+1));
                    val y1 = Float.parse(splits(0+2));
                    val z1 = Float.parse(splits(0+3));
                    val u1 = Float.parse(splits(0+4));
                    val v1 = Float.parse(splits(0+5));

                    val x2 = Float.parse(splits(5+1));
                    val y2 = Float.parse(splits(5+2));
                    val z2 = Float.parse(splits(5+3));
                    val u2 = Float.parse(splits(5+4));
                    val v2 = Float.parse(splits(5+5));

                    val x3 = Float.parse(splits(10+1));
                    val y3 = Float.parse(splits(10+2));
                    val z3 = Float.parse(splits(10+3));
                    val u3 = Float.parse(splits(10+4));
                    val v3 = Float.parse(splits(10+5));

                    val m = matTable.getOrElse(splits(16),white);
                    scene.insert(new UVTriangle(Vector3(x1,y1,z1),Vector3(x2,y2,z2),Vector3(x3,y3,z3),Vector3(u1,u2,u3),Vector3(v1,v2,v3),m));
                } else if (here == Place.FIRST_PLACE) {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (here == Place.FIRST_PLACE) {
                Console.ERR.println("Did not understand: "+line_);
            }
        }

        if (dumpOctree) Console.OUT.println(scene);

        return this;
    }

    public static def to_col(x:Vector3) {
        val scaled = x*0.5f + Vector3(0.5f,0.5f,0.5f);
        return RGB(scaled.x, scaled.y, scaled.z);
    }


    public final def castRay (s:RayState) {
        s.t = Float.MAX_VALUE;
        //scene.iterateCargo((p:Primitive) => { p.intersectRay(s); });
        scene.castRay(s);
        if (s.t == Float.MAX_VALUE) {
            val dn = s.d.normalised();
            //return RGB.BLACK;
            //return to_col(dn);
            if (dn.x > 0 && Math.abs(dn.y/dn.x) < 1 && Math.abs(dn.z/dn.x) < 1) return to_col(Vector3( 1,0,0));
            else if (dn.x < 0 && Math.abs(dn.y/dn.x) < 1 && Math.abs(dn.z/dn.x) < 1) return to_col(Vector3(-1,0,0));
            else if (dn.y > 0 && Math.abs(dn.x/dn.y) < 1 && Math.abs(dn.z/dn.y) < 1) return to_col(Vector3(0, 1,0));
            else if (dn.y < 0 && Math.abs(dn.x/dn.y) < 1 && Math.abs(dn.z/dn.y) < 1) return to_col(Vector3(0,-1,0));
            else if (dn.z > 0 && Math.abs(dn.x/dn.z) < 1 && Math.abs(dn.y/dn.z) < 1) return to_col(Vector3(0,0, 1));
            else                                                                     return to_col(Vector3(0,0,-1));
        } else {
            return s.mat.render(this,s);
        }
    }

    public def renderFrame (raw:RemoteIndexedMemoryChunk[RGB]) {
        val horz_split = here.id % horzSplits;
        val vert_split = here.id / horzSplits;

        val offset_x = horz_split * localWidth;
        val offset_y = vert_split * localHeight;

        if (verbose)
            Console.OUT.println(here+" rendering "+horz_split+","+vert_split+"    "+offset_x+","+offset_y);


        //val before = Runtime.getX10RTStats();
        //val render_before = System.nanoTime();
        finish {
            val state = new RayState(this);
            state.o = pos;

            val forwards = orientation * Vector3(0,1,0);
            val right = orientation * Vector3(1,0,0);
            val up = orientation * Vector3(0,0,1);
            //Console.OUT.println("forwards: "+forwards);

            for (y in 0..(localHeight-1)) {
                // y_norm: centre of pixel, normalised to -1 -> 1 range
                // note inversion of axis so -1,-1 is bottom left of screen
                val y_norm = -(y+0.5f+offset_y)/globalHeight*2.0f + 1.0f;

                for (x in 0..(localWidth-1)) {
                    // linear projection
                    // x_norm: center of pixel, normalised to -1 -> 1 range
                    val x_norm = (x+0.5f+offset_x)/globalWidth*2.0f - 1.0f;
                    // FOV of 90
                    val ray = x_norm * globalWidth/globalHeight * right
                            + forwards
                            + y_norm * up;
                    state.d = ray * 800;
                    localFrame(y*localWidth + x) = castRay(state);
                }
                IndexedMemoryChunk.asyncCopy(localFrame.raw(), y*localWidth, raw, offset_x + (offset_y+y)*globalWidth, localWidth);
            }
        }
        //Console.OUT.println(here+" "+(System.nanoTime() - render_before)/1E9);
        //Console.OUT.println(here+" "+(Runtime.getX10RTStats() - before));
    }

}

// vim: shiftwidth=4:tabstop=4:expandtab

