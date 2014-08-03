package raytracer;

import x10.io.Console;

public class QuatTest {
    public static def main(args:Rail[String]) {
        Console.OUT.println(Quat.angleAxis(90, 0, 1, 0));
    }
}

// vim: shiftwidth=4:tabstop=4:expandtab
