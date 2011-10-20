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

    public var camPos : Vector3;
    public var camYaw : Float;
    public var camPitch : Float;

    public def loadScene(fileName:String) {

        val white = new SolidColour(RGB.WHITE);

        matTable.put("REFLECTIVE", new Reflective());

        val file = new File(fileName);
        for (line_ in file.lines()) {
            val line = line_.trim();
            if (line.length()==0) continue;
            val splits = line.split("#")(0).split(" ");
            if (splits.size==0) continue;
            if (splits(0).equalsIgnoreCase("MAT_SOLID")) {
                if (splits.size == 5) {
                    val name = splits(1);
                    val r = UInt.parse(splits(2));
                    val g = UInt.parse(splits(3));
                    val b = UInt.parse(splits(4));
                    matTable.put(name, new SolidColour(RGB(r,g,b)));
                } else {
                    Console.ERR.println("Did not understand: "+line_);
                }
            } else if (splits(0).equalsIgnoreCase("MAT_TEX")) {
                if (splits.size == 5) {
                    val name = splits(1);
                    val w = Int.parse(splits(2));
                    val h = Int.parse(splits(3));
                    val texname = splits(4);
                    if (w>512 || h>512) {
                        Console.ERR.println("Texture file size error: \""+texname+"\": textures cannot be larger than 512x512");
                    } else {
                        val tex_file = new File(texname);
                        val fr = tex_file.openRead();
                        val num_file_texels = (tex_file.size() / 3) as Int;
                        if (num_file_texels == w * h) {
                            val init_points = (int) => RGB(Marshal.UBYTE.read(fr), Marshal.UBYTE.read(fr), Marshal.UBYTE.read(fr));
                            val file_colours = new Array[RGB](num_file_texels, init_points);
                            val tex = new Texture2D(w,h);
                            tex.init((x:Int, y:Int) => file_colours(y*w + x));
                            matTable.put(name, new Textured(tex));
                        } else {
                            Console.ERR.println("Texture file size error: \""+texname+"\":"+w+" * "+w+" != "+num_file_texels);
                        }
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
                    prims.add(new Sphere(Vector3(x,y,z),r,m));
                } else {
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
                    prims.add(new Triangle(Vector3(x1,y1,z1),Vector3(x2,y2,z2),Vector3(x3,y3,z3),m));
                } else {
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
                    prims.add(new DoubleTriangle(Vector3(x1,y1,z1),Vector3(x2,y2,z2),Vector3(x3,y3,z3),m));
                } else {
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
                    prims.add(new UVTriangle(Vector3(x1,y1,z1),Vector3(x2,y2,z2),Vector3(x3,y3,z3),Vector3(u1,u2,u3),Vector3(v1,v2,v3),m));
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
            } else {
                Console.ERR.println("Did not understand: "+line_);
            }
        }

    }
}


// vim: shiftwidth=4:tabstop=4:expandtab

