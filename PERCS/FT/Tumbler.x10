class Tumbler(W:Int) {
        var turn:Int=0n;
        def await(i:Int) {
            when (turn == i);
        }
        def advance(i:Int) {
            atomic {
                assert turn == i : "Illegal operation on tumbler";
                turn = (i+1n)%W;
            }
        }
    }