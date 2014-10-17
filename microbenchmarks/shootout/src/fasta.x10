/*
 * The Great Computer Language Shootout
 * http://shootout.alioth.debian.org/
 * 
 * based on Java-6 version by Mehmet D. AKIN
 * 
 * 
* v2: v1 + general clean up and use x10 idioms*/

import x10.io.IOException;
import x10.io.Printer;
import x10.util.RailUtils;

public class fasta {
    static val IM = 139968N;
    static val IA = 3877N;
    static val IC = 29573N;
    var last:Int = 42N;

    static val LINE_LENGTH = 60;

    // pseudo-random number generator
    def random(max:double) {
        last = (last * IA + IC) % IM;
        return max * last / IM;
    }

    static val NEWLINE = '\n'.ord() as byte;

    // Weighted selection from alphabet
    static val ALU =
    "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG"
    + "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA"
    + "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT"
    + "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA"
    + "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG"
    + "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC"
    + "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA";
    static val ALUB = ALU.bytes();

    static val cum  = (f1:frequency, f2:frequency) =>  frequency(f2.c, f1.p + f2.p);

    static val IUB = RailUtils.scan([
        frequency('a'.ord() as byte, 0.27),
        frequency('c'.ord() as byte, 0.12),
        frequency('g'.ord() as byte, 0.12),
        frequency('t'.ord() as byte, 0.27),

        frequency('B'.ord() as byte, 0.02),
        frequency('D'.ord() as byte, 0.02),
        frequency('H'.ord() as byte, 0.02),
        frequency('K'.ord() as byte, 0.02),
        frequency('M'.ord() as byte, 0.02),
        frequency('N'.ord() as byte, 0.02),
        frequency('R'.ord() as byte, 0.02),
        frequency('S'.ord() as byte, 0.02),
        frequency('V'.ord() as byte, 0.02),
        frequency('W'.ord() as byte, 0.02),
        frequency('Y'.ord() as byte, 0.02) ],
        cum, frequency(0Y, 0.0));

    static val HomoSapiens = RailUtils.scan([
        frequency('a'.ord() as byte, 0.3029549426680d),
        frequency('c'.ord() as byte, 0.1979883004921d),
        frequency('g'.ord() as byte, 0.1975473066391d),
        frequency('t'.ord() as byte, 0.3015094502008d)],
        cum, frequency(0Y, 0.0));


    // naive
    def selectRandom(a:Rail[frequency]) {
        val r = random(1.0);
        for (i in 0..(a.size-1)) 
            if (r < a(i).p) return a(i).c;

        return a(a.size-1).c;
    }

    static val BUFFER_SIZE = 1024;
    static val bbuffer = new Rail[Byte](BUFFER_SIZE, 0Y);

    def makeRandomFasta(id:String, desc:String, a:Rail[frequency], var n:Long, printer:Printer) {
        writeDesc(id,desc,printer);
        var index:Long = 0;
        while (n > 0) {
            val m = (n < LINE_LENGTH) ? n : LINE_LENGTH;
            if (BUFFER_SIZE - index < m) {
                printer.write(bbuffer, 0, index);
                index = 0;
            }
            for (i in 0..(m-1)) {
                bbuffer(index++) = selectRandom(a);
            }
            bbuffer(index++) = NEWLINE;
            n -= LINE_LENGTH;
        }
        if(index != 0) printer.write(bbuffer, 0, index);
    }

    def makeRepeatFasta(id:String, desc:String, alu:String, var n:Long, printer:Printer) {
        writeDesc(id,desc,printer);
        var index:Long = 0;
        var k:Long = 0;
        val kn = ALUB.size;

        while (n > 0) {
            val m = (n < LINE_LENGTH) ? n : LINE_LENGTH;

            if (BUFFER_SIZE - index < m) {
                printer.write(bbuffer, 0, index);
                index = 0;
            }
            for (i in 0..(m-1)) {
                if (k == kn) k = 0;
                bbuffer(index++) = ALUB(k++);
            }
            bbuffer(index++) = NEWLINE;
            n -= LINE_LENGTH;
        }
        if (index != 0) printer.write(bbuffer, 0, index);
    }

    static def writeDesc(id:String, desc:String, printer:Printer) {
        val descStr = ">" + id + " " + desc + '\n';
        printer.print(descStr);
    }

    public static def main(args:Rail[String]) {
        val n = (args.size > 0) ? Long.parse(args(0)) : 2500000;
        val f = new fasta();
        f.makeRepeatFasta("ONE", "Homo sapiens alu", ALU, n * 2, Console.OUT);
        f.makeRandomFasta("TWO", "IUB ambiguity codes", IUB, n * 3, Console.OUT);
        f.makeRandomFasta("THREE", "Homo sapiens frequency", HomoSapiens, n * 5, Console.OUT);
    }

    static struct frequency(c:Byte, p:Double) { }
}
