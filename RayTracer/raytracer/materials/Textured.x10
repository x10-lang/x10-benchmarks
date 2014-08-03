package raytracer.materials;

import raytracer.*;

public class Textured(amb:Vector3, diff:Vector3, spec:Vector3, gloss:Float, tex:Texture2D) extends Material {

    public def render(rt:Engine, s:RayState) {
        // use height as this is where the FOV is 90
        val texels_per_pixel = Math.abs(s.t * Math.max(tex.height(), tex.width())*s.texSquash / (2 * rt.globalHeight));
        var mipmap_level : Int = Math.getExponent(texels_per_pixel);
        //Console.OUT.println(texels_per_pixel+" "+mipmap_level);

        val texel = tex(s.texCoord, mipmap_level + rt.mipmapBias);
        return rt.lightingEquation(s.hasShadow ? s.child : null, amb as Vector3 * texel, diff as Vector3 * texel, spec as Vector3, gloss, s.normal, s.o + s.t*s.d, -s.d);
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
