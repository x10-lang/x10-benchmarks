package raytracer;

public class Texture2DTest {
    public static def main(args:Rail[String]) {
        val tex = new Texture2D(512n,512n);
        tex.init((x_:Int, y_:Int) => {
            val x = (x_-256) / 256.0f;
            val y = (y_-256) / 256.0f;
            return (x*x + y*y > 1) ? RGB.BLACK : RGB.RED;
        });
        //for (var y:Int=0 ; y<128 ; ++y) {
        //    for (var x:Int=0 ; x<128 ; ++x) {
        //        Console.OUT.print(tex.mipmap(1n).raw()(y*128+x)+" ");
        //    }
        //    Console.OUT.println();
        //}
        for (var y:Float=-3 ; y<=3 ; y+=0.1) {
            for (var x:Float=-3 ; x<=3 ; x+=0.1) {
                Console.OUT.print(tex(Vector2(x,y),0n).x > 0.5 ? " " : "X");
            }
            Console.OUT.println();
        }
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
