package raytracer;

import x10.io.Console;

import x10.util.HashMap;
import x10.util.ArrayList;

import x10.io.*;

import raytracer.primitives.*;
import raytracer.materials.*;

public class SceneLoader {

    public val matTable = new HashMap[String, Material]();
    public val prims = new ArrayList[Primitive]();

    public var camPos:Vector3;
    public var camYaw:Float;
    public var camPitch:Float;

    val vertexes = new ArrayList[MeshVertex]();
    var vertexCurrOffset:UShort = 0us;

    private static def isPowerOf2(x:Int) = 0n == (x & (x-1n));

    public var skybox:Rail[Texture2D] = null;

    public def loadScene(fileName:String) {

        val white = new SolidColour(RGB.WHITE as Vector3, RGB.WHITE as Vector3, RGB.BLACK as Vector3, 10);
        val metallic_grey = new SolidColour(RGB.GREY as Vector3, RGB.GREY as Vector3, RGB.GREY as Vector3, 20);

        var mesh_vert_pos:Vector3 = Vector3(0,0,0);
        var mesh_vert_normal:Vector3 = Vector3(0,0,1);
        var mesh_vert_uv:Vector2 = Vector2(0,0);
        var mesh_mat:Material = white;

        val debug = new DebugMaterial();
        matTable.put("DEBUG", debug);

        val file = new File(fileName);
        for (line_ in file.lines()) {
            val line = line_.trim();
            if (line.length()==0n) continue;
            val splits_ = line.split("#")(0).split(" ");
            val splits__ = new ArrayList[String]();
            for (s in splits_) {
                if (s.length() > 0) splits__.add(s);
            }
            val splits = splits__.toRail();
            if (splits.size==0) continue;
            if (splits(0).equalsIgnoreCase("MAT_SOLID")) {
                if (splits.size == 12) {
                    val name = splits(1);
                    val ar = Float.parse(splits(2));
                    val ag = Float.parse(splits(3));
                    val ab = Float.parse(splits(4));
                    val dr = Float.parse(splits(5));
                    val dg = Float.parse(splits(6));
                    val db = Float.parse(splits(7));
                    val sr = Float.parse(splits(8));
                    val sg = Float.parse(splits(9));
                    val sb = Float.parse(splits(10));
                    val gloss = Float.parse(splits(11));
                    matTable.put(name, new SolidColour(Vector3(ar,ag,ab),Vector3(dr,dg,db),Vector3(sr,sg,sb),gloss));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MAT_REFRACTINGWATER")) {
                if (splits.size == 11) {
                    val name = splits(1);
                    val subname = splits(2);
                    val fresnel = Float.parse(splits(3));
                    val refractive_index = Float.parse(splits(4));
                    val am_r = Float.parse(splits(5));
                    val am_g = Float.parse(splits(6));
                    val am_b = Float.parse(splits(7));
                    val em_r = Float.parse(splits(8));
                    val em_g = Float.parse(splits(9));
                    val em_b = Float.parse(splits(10));
                    val sm = matTable.getOrElse(subname,white);
                    matTable.put(name, new RefractingWater(sm, fresnel, refractive_index, Vector3(am_r,am_g,am_b),Vector3(em_r,em_g,em_b)));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MAT_REFLECTIVE")) {
                if (splits.size == 6) {
                    val name = splits(1);
                    val subname = splits(2);
                    val r = Float.parse(splits(3));
                    val g = Float.parse(splits(4));
                    val b = Float.parse(splits(5));
                    val sm = matTable.getOrElse(subname,white);
                    matTable.put(name, new Reflective(sm,Vector3(r,g,b)));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MAT_TEX")) {
                if (splits.size == 15) {
                    val name = splits(1);
                    val w = Int.parse(splits(2));
                    val h = Int.parse(splits(3));
                    val texname = splits(4);
                    val ar = Float.parse(splits(5));
                    val ag = Float.parse(splits(6));
                    val ab = Float.parse(splits(7));
                    val dr = Float.parse(splits(8));
                    val dg = Float.parse(splits(9));
                    val db = Float.parse(splits(10));
                    val sr = Float.parse(splits(11));
                    val sg = Float.parse(splits(12));
                    val sb = Float.parse(splits(13));
                    val gloss = Float.parse(splits(14));
                    if (w>512 || h>512) {
                        Console.ERR.println("Texture file size error: \""+texname+"\": textures cannot be larger than 512x512");
                    } else if (!isPowerOf2(w) || !isPowerOf2(h)) {
                        Console.ERR.println("Texture file size error: \""+texname+"\": texture width/height must be power of 2");
                    } else {
                        val tex = new Texture2D(w,h);
                        initTexFromFile(tex, w, h, texname);
                        matTable.put(name, new Textured(Vector3(ar,ag,ab),Vector3(dr,dg,db),Vector3(sr,sg,sb),gloss,tex));
                    }
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("SPHERE")) {
                if (splits.size == 6) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));
                    val r = Float.parse(splits(4));
                    val m = matTable.getOrElse(splits(5),white);
                    prims.add(new Sphere(Vector3(x,y,z),r,m));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("SPECKLEDSPHERE")) {
                if (splits.size == 6) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));
                    val r = Float.parse(splits(4));
                    val m = matTable.getOrElse(splits(5),white);
                    prims.add(new SpeckledSphere(Vector3(x,y,z),r,m));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("WAVEY_RECT")) {
                if (splits.size == 7) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));

                    val w = Float.parse(splits(4));
                    val h = Float.parse(splits(5));

                    val m = matTable.getOrElse(splits(6),white);
                    prims.add(new WaveyRectangle(Vector3(x,y,z),w,h,m));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("CUDA_RECT")) {
                if (splits.size == 7) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));

                    val w = Float.parse(splits(4));
                    val h = Float.parse(splits(5));

                    val m = matTable.getOrElse(splits(6),white);
                    prims.add(new CUDARectangle(Vector3(x,y,z),w,h,m));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("RECT")) {
                if (splits.size == 22) {
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

                    val x4 = Float.parse(splits(15+1));
                    val y4 = Float.parse(splits(15+2));
                    val z4 = Float.parse(splits(15+3));
                    val u4 = Float.parse(splits(15+4));
                    val v4 = Float.parse(splits(15+5));

                    val m = matTable.getOrElse(splits(21),white);
                    prims.add(new Rectangle(Vector3(x1,y1,z1),Vector2(u1,v1),Vector3(x2,y2,z2),Vector2(u2,v2),Vector3(x3,y3,z3),Vector2(u3,v3),Vector3(x4,y4,z4),Vector2(u4,v4),m));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("CAMERA")) {
                if (splits.size == 6) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));
                    val yaw = Float.parse(splits(4));
                    val pitch = Float.parse(splits(5));
                    camPos = Vector3(x,y,z);
                    camYaw = yaw;
                    camPitch = pitch;
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MESH_RESET")) {
                if (splits.size == 2) {
                    mesh_mat = matTable.getOrElse(splits(1),white);
                    vertexCurrOffset = vertexes.size() as UShort;
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MESH_FACE")) {
                if (splits.size == 4) {
                    val v1 = vertexCurrOffset + UShort.parse(splits(1));
                    val v2 = vertexCurrOffset + UShort.parse(splits(2));
                    val v3 = vertexCurrOffset + UShort.parse(splits(3));
                    if (v1 as UInt as Int > vertexes.size()) {
                        Console.ERR.println("Vertex 1 overflows at this face: "+line_);
                    } else if (v2 as UInt as Int > vertexes.size()) {
                        Console.ERR.println("Vertex 2 overflows at this face: "+line_);
                    } else if (v3 as UInt as Int > vertexes.size()) {
                        Console.ERR.println("Vertex 3 overflows at this face: "+line_);
                    } else {
                        val V1 = vertexes(v1 as UInt as Int);
                        val V2 = vertexes(v2 as UInt as Int);
                        val V3 = vertexes(v3 as UInt as Int);
                        prims.add(new MeshTriangle(v1,v2,v3,V1,V2,V3,mesh_mat));
                    }
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MESH_VERT_COMPLETE")) {
                if (splits.size == 1) {
                    vertexes.add(MeshVertex(mesh_vert_pos, mesh_vert_normal, mesh_vert_uv));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MESH_VERT_NORMAL")) {
                if (splits.size == 4) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));
                    mesh_vert_normal = Vector3(x,y,z);
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MESH_VERT_POS")) {
                if (splits.size == 4) {
                    val x = Float.parse(splits(1));
                    val y = Float.parse(splits(2));
                    val z = Float.parse(splits(3));
                    mesh_vert_pos = Vector3(x/100.0f,y/100.0f,z/100.0f);
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MESH_VERT_UV")) {
                if (splits.size == 3) {
                    val u = Float.parse(splits(1));
                    val v = Float.parse(splits(2));
                    mesh_vert_uv = Vector2(u,v);
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("SKYBOX")) {
                if (splits.size == 8) {
                    val w = Int.parse(splits(1));
                    val h = w;
                    val texname = new Rail[String](6, (i:Long) => splits(i+2));
                    if (w>512 || h>512) {
                        Console.ERR.println("Skybox file size error: \""+texname(0)+"\": textures cannot be larger than 512x512");
                        skybox = null;
                    } else if (!isPowerOf2(w) || !isPowerOf2(h)) {
                        Console.ERR.println("Skybox file size error: \""+texname(0)+"\": textures width/height must be power of 2");
                        skybox = null;
                    } else {
                        skybox = new Rail[Texture2D](6, (i:Long)=>new Texture2D(w,h));
                        for (i in 0..5) {
                            initTexFromFile(skybox(i), w, h, texname(i));
                        }
                    }
                } else if (splits.size == 2 && splits(1).equalsIgnoreCase("NONE")) {
                    skybox = null;
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else {
                Console.ERR.println("Did not understand: "+line_);
            }
        }

    }

    private static def initTexFromFile(tex:Texture2D, w:Int, h:Int, texname:String) {
        val tex_file = new File(texname);
        val fr = tex_file.openRead();
        val num_file_texels = (tex_file.size() / 3) as Int;
        if (num_file_texels == w * h) {
            val file_colours = new Rail[RGB](num_file_texels, (Long)=>RGB(Marshal.UBYTE.read(fr), Marshal.UBYTE.read(fr), Marshal.UBYTE.read(fr)));
            tex.init((x:Int, y:Int) => file_colours(y*w + x));
        } else {
            Console.ERR.println("Texture file size error: \""+texname+"\":"+w+" * "+h+" != "+num_file_texels);
            tex.init((x:Int, y:Int) => RGB.RED);
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
