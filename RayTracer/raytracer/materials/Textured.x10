package raytracer.materials;

import raytracer.*;

public class Textured(tex:Texture2D) extends Material {
    public def render (rt:Engine, s:RayState) : RGB {
        val col = tex(s.texCoord.first, s.texCoord.second, 0);
        return rt.lightingEquation(col, col, s.normal, s.o + s.t*s.d);
    }
}

