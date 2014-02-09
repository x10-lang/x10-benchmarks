/*
 * The Computer Language Benchmarks Game
 * http://shootout.alioth.debian.org/
 * 
 * 
 *  based on Java 6 -server version by  Anthony Donnefort
* 
* v2: v1 + general clean up and use x10 idioms
 */

import x10.io.EOFException;
import x10.io.File;
import x10.io.FileReader;
import x10.util.ArrayList;
import x10.io.IOException;
import x10.io.InputStreamReader;
import x10.io.OutputStreamWriter;
import x10.io.Reader;

public class revcomp {

    val cmp = new Rail[byte](128, (i:long)=>i as byte);

    static val NEWLINE = '\n'.ord() as byte;

    def this() {
        cmp('t'.ord()) = cmp('T'.ord()) = 'A'.ord() as byte;
        cmp('a'.ord()) = cmp('A'.ord()) = 'T'.ord() as byte;
        cmp('g'.ord()) = cmp('G'.ord()) = 'C'.ord() as byte;
        cmp('c'.ord()) = cmp('C'.ord()) = 'G'.ord() as byte;
        cmp('v'.ord()) = cmp('V'.ord()) = 'B'.ord() as byte;
        cmp('h'.ord()) = cmp('H'.ord()) = 'D'.ord() as byte;
        cmp('r'.ord()) = cmp('R'.ord()) = 'Y'.ord() as byte;
        cmp('m'.ord()) = cmp('M'.ord()) = 'K'.ord() as byte;
        cmp('y'.ord()) = cmp('Y'.ord()) = 'R'.ord() as byte;
        cmp('k'.ord()) = cmp('K'.ord()) = 'M'.ord() as byte;
        cmp('b'.ord()) = cmp('B'.ord()) = 'V'.ord() as byte;
        cmp('d'.ord()) = cmp('D'.ord()) = 'H'.ord() as byte;
        cmp('u'.ord()) = cmp('U'.ord()) = 'A'.ord() as byte;

    }

    class ReversibleByteArray  {

        var r:ArrayList[byte] = new ArrayList[byte]();

        def reset() {  
            r = new ArrayList[byte]();
        }

        def reverse() {
            if (r.size() > 0) {
                var begin:int = 0n;
                var end:int = (r.size() - 1) as int;
                	while (begin <= end) {
	                    if (r(begin) == NEWLINE)begin++;
	                    if (r(end) == NEWLINE)end--;
	                    if (begin <= end) {
	                        val tmp = r(begin);
	                        r(begin++) = cmp(r(end));
	                        r(end--) = cmp(tmp);
	                    }
	                    
	                }
                	Console.OUT.write(r.toRail(),0,r.toRail().size);
	             	//Console.OUT.println();
            }
        }

        def write(s: String, off:int, len:int) {
            for (var i:int = off; i <off+len; i++) 
                r.add(s.charAt(i).ord() as byte);
            r.add(NEWLINE);
        }   
    }

    public static def main(args:Rail[String]) {
        val rc = new revcomp();
        Console.OUT.println(NEWLINE);
        rc.go(args(0));
    }

    def go(temp:String) {
    	val f = new File("./" + temp + ".txt");
    	assert f.exists();
        val input = new FileReader(f);
        val buf = new ReversibleByteArray();
        try {
            while (true) {
                val line = input.readLine();
                val read = line.length();
                var i:int = 0n;
                var last:int = 0n;
                while (i < read) {
                    if (line.charAt(i) == '>') {
                        buf.write(line, last, i - last);
                        buf.reverse();
                        buf.reset();
                        last = i;
                    }
                    i++;
                }
                buf.write(line, last, read - last);
            }
        } catch (e:EOFException) {
            // do nothing
        }
        buf.reverse();
       
    }
}
