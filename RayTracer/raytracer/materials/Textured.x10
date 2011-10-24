package raytracer.materials;

import raytracer.*;

import x10.compiler.Native;

public class Textured(amb:Vector3, diff:Vector3, spec:Vector3, gloss:Float, tex:Texture2D) extends Material {
    public def render (rt:Engine, s:RayState) {
        val texel = tex(s.texCoord, 0 + rt.mipmapBias);
        return rt.lightingEquation(s.child, amb as Vector3 * texel, diff as Vector3 * texel, spec as Vector3, gloss, s.normal, s.o + s.t*s.d, -s.d);

        /*
        // choose a mipmap level
        val texels_per_pixel = s.t * Math.max(tex.height(), tex.width())*s.texSquash / (2 * rt.globalHeight); // use height as this is where the FOV is 90
        var mipmap_level : Int = 0;
        @Native("c++", "mipmap_level = ilogbf(texels_per_pixel);") { }
        mipmap_level = Math.max(0, mipmap_level);

        val col = tex(s.texCoord.x, s.texCoord.y, mipmap_level + rt.mipmapBias);

        return rt.lightingEquation(col, col, s.normal, s.o + s.t*s.d);
        switch (mipmap_level) {
            case 0: return RGB.RED;
            case 1: return RGB.ORANGE;
            case 2: return RGB.YELLOW;
            case 3: return RGB.GREEN;
            case 4: return RGB.CYAN;
            case 5: return RGB.BLUE;
            default: return RGB.BLACK;
        }
        */
    }
}

