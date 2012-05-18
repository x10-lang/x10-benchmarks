import x10.compiler.Native;
import x10.compiler.Pragma;
import x10.util.ArrayBuilder;

class Random {
    @Native("c++", "srandom(#seed)")
    static native def srandom(seed:Int):void;

    @Native("c++", "random()")
    native def rand():Long;

    def this(seed:Int) {
        srandom(seed);
    }

    def next() = (rand() & 3L) as Byte; // 0..alphabetSize-1
}

class Parameters {
    val openGapPenalty = 2;
    val extendGapPenalty = 1;
    val matchScore = 4y;
    val mismatchScore = -3y;
    val alphabetSize = 4;
    val shortLength:Int;
    val longLength:Int;
    val seed:Int;
    val scoringMatrix = new Rail[Byte](alphabetSize*alphabetSize);
    val overlap:Int;
    val segmentCount:Int;
    val baseSegmentLength:Int;
    val shortfall:Int;

    def this(shortLength:Int, longLength:Int, seed:Int) {
        this.shortLength = shortLength;
        this.longLength = longLength;
        this.seed = seed;

        for (var i:Int=0; i<alphabetSize;i++) {
            for (var j:Int=0; j<alphabetSize;j++) {
                scoringMatrix(i*alphabetSize+j) = (i==j) ? matchScore : mismatchScore;
            }
        }

        var maxScoreOnMatch:Int = matchScore*shortLength;
        val maxAlignedLength = (openGapPenalty <= extendGapPenalty) ?
                shortLength - 1 + maxScoreOnMatch/openGapPenalty :
                    shortLength + (maxScoreOnMatch-openGapPenalty)/extendGapPenalty;
        overlap = maxAlignedLength - 1;
        val mostWeCanUse = (2*overlap >= longLength) ? 1 : (longLength-overlap)/overlap;
        segmentCount = (mostWeCanUse>Place.MAX_PLACES) ? Place.MAX_PLACES : mostWeCanUse;
        baseSegmentLength = overlap + (longLength - overlap)/segmentCount;
        shortfall = (longLength-overlap) % segmentCount;

        Runtime.println("places: " + segmentCount + "/" + Place.MAX_PLACES + " short: " + shortLength + " long: " + longLength + " seed: " + seed);
    }
}

class SW {
    val BAD = 0y, STOP = 1y, LEFT = 2y, DIAGONAL = 3y, UP = 4y;
    val GAP = -1y;

    val params:Parameters;
    val short:Rail[Byte];
    val long:Rail[Byte];
    val tracebackMoves:Rail[Rail[Byte]];
    val bestScoreUpTo_I_J:Rail[Int];
    val first:Int;
    val last:Int;
    val localSize:Int;
    val placeId = Runtime.hereInt();

    var winningScore:Int = 0;
    var shortLast:Int = -1;
    var longLast:Int = -1;

    def this(params:Parameters) {
        this.params = params;
        val baseOffset = placeId*(params.baseSegmentLength - params.overlap);
        first = (placeId < params.shortfall) ? baseOffset + placeId: baseOffset + params.shortfall;
        val size = (placeId < params.shortfall ? params.baseSegmentLength + 1 : params.baseSegmentLength);
        localSize = size;
        last = first + size;
        val r = new Random(params.seed);
        short = new Rail[Byte](params.shortLength);
        long = new Rail[Byte](size);
        for (var i:Int=0; i<params.shortLength; i++) {
            short(i) = r.next();
        }
        for (var i:Int=0; i<last; i++) {
            val v = r.next();
            if (i>=first) long(i-first) = v;
        }
        if (placeId < params.segmentCount) {
            Runtime.println("place=" + placeId + " [" + first + ","+ last +"[");
        }
        tracebackMoves = new Rail[Rail[Byte]](params.shortLength+1, (Int)=>new Rail[Byte](size + 1));
        bestScoreUpTo_I_J = new Rail[Int](size + 1);
    }

    def run(scores:GlobalRef[Rail[Int]]) {
        val scoringMatrix = params.scoringMatrix;
        val alphabetSize = params.alphabetSize;
        val extendGapPenalty = params.extendGapPenalty;
        val openGapPenalty = params.openGapPenalty;
        val shortSize = params.shortLength;

        for (var i:Int=0; i<=shortSize; i++) tracebackMoves(i)(0) = STOP;
        for (var j:Int=0; j<=localSize; j++) tracebackMoves(0)(j) = STOP;
        for (var j:Int=0; j<=localSize; j++) bestScoreUpTo_I_J(j) = 0;

        winningScore = -1;
        shortLast = -1;
        longLast = -1;

        for (var i:Int=1; i<=shortSize; i++) {
            var previousBestScore:Int = 0;
            val s = short(i-1)*alphabetSize;
            for (var j:Int=1; j<=localSize; j++) {
                val scoreOfMatchAtLast = scoringMatrix(s + long(j-1));
                val scoreUsingLatestIJ = previousBestScore + scoreOfMatchAtLast;
                val bestIfGapInsertedInI = bestScoreUpTo_I_J(j) - (tracebackMoves(i-1)(j)==UP ? extendGapPenalty : openGapPenalty);
                val bestIfGapInsertedInJ = bestScoreUpTo_I_J(j-1) - (tracebackMoves(i)(j-1)==LEFT ? extendGapPenalty : openGapPenalty);     
                val winner = maxOrZero(scoreUsingLatestIJ, bestIfGapInsertedInI, bestIfGapInsertedInJ);
                previousBestScore = bestScoreUpTo_I_J(j);
                bestScoreUpTo_I_J(j) = winner;
                if (winner == 0)                         tracebackMoves(i)(j) = STOP;
                else if (winner == scoreUsingLatestIJ)   tracebackMoves(i)(j) = DIAGONAL;
                else if (winner == bestIfGapInsertedInI) tracebackMoves(i)(j) = UP;
                else                                     tracebackMoves(i)(j) = LEFT;
                if (winner > winningScore) {
                    winningScore = winner;
                    shortLast = i;
                    longLast = j;
                }
            }
        }
        Runtime.println("place=" + placeId + " score=" + winningScore + " short=" + shortLast + " long=" + (first+longLast));
        val p = placeId;
        val score = winningScore;
        at (scores) async { scores()(p) = score; }
    }

    static def maxOrZero(a:Int, b:Int, c:Int) {
        if (a > b) {
            if (a > c) return a > 0 ? a : 0; else return c > 0 ? c : 0;
        } else {
            if (b > c) return b > 0 ? b : 0; else return c > 0 ? c : 0;
        }
    }

    def result() {
        var nextMove:Byte;
        var i:Int = shortLast;
        var j:Int = longLast;
        val shortBuilder = new ArrayBuilder[Byte]();
        val longBuilder  = new ArrayBuilder[Byte]();
        var done:Boolean = false;
        while (!done) {
            nextMove = tracebackMoves(i)(j);
            switch (nextMove) {
            case UP:
                shortBuilder.add(short(--i));
                longBuilder.add(GAP);
                break;
            case DIAGONAL:
                shortBuilder.add(short(--i));
                longBuilder.add(long(--j));
                break;
            case LEFT:
                shortBuilder.add(GAP);
                longBuilder.add(long(--j));
                break;
            case STOP:
                done = true;
                break;
            }
        }
        val s = shortBuilder.result();
        val l = longBuilder.result();
        return "short=[" + i + "," + shortLast + "[ long=[" + (first+j) + "," + (first+longLast) +"[";
    }

    public static def main(args:Array[String](1)) {
        var t:Long = System.nanoTime();
        val shortLength = Int.parseInt(args(0));
        val longLength = Int.parseInt(args(1));
        val seed = Int.parseInt(args(2));
        val params = new Parameters(shortLength, longLength, seed);
        val plh = PlaceLocalHandle.makeFlat(Dist.makeUnique(), ()=>Runtime.hereInt()<params.segmentCount ? new SW(params) : null);
        val scores = new Rail[Int](params.segmentCount);
        val ref = GlobalRef[Rail[Int]](scores);
        Runtime.println("Initialization: " + ((System.nanoTime()-t)/1e9) + "s");
        
        for (var k:Int=0; k<10; k++) {
            t = System.nanoTime();
            @Pragma(Pragma.FINISH_HERE) finish for (var i:Int=0; i<params.segmentCount; i++) {
                at (Place(i)) async plh().run(ref);
            }
            var winningScore:Int = -1;
            var p:Int = -1;
            for (var i:Int=0; i<params.segmentCount; i++) {
                if (scores(i) > winningScore) {
                    p = i;
                    winningScore = scores(i);
                }
            }
            Runtime.println("Scoring: " + ((System.nanoTime()-t)/1e9) + "s");
            t = System.nanoTime();
            val r = at (Place(p)) plh().result();
            Runtime.println("Trace: " + ((System.nanoTime()-t)/1e9) + "s");
            Runtime.println("place=" + p + " " + r);
        }
    }
}
