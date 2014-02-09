/** 
* The Computer Language Benchmarks Game
* http://shootout.alioth.debian.org/
* 
* Based on Java-6 version, Jarkko Miettinen
* 
* v2: v1 + general clean up and use x10 idioms
*/
class binarytrees {
    private static val minDepth = 4n;

    public static def main(args:Rail[String]) {
        for(var o:int = 0n; o < 10n; o++){
            val Starttime = System.nanoTime();
            val n = args.size > 0 ? Int.parse(args(0)) : 0n; 

            val maxDepth = (minDepth + 2n > n) ? minDepth + 2n : n;
            val stretchDepth = maxDepth + 1n;

            var check:int = tree(0n, stretchDepth).itemCheck();
        
            Console.OUT.println("stretch tree of depth "+stretchDepth+"\t check: " + check);

            val longLivedTree = tree(0n,maxDepth);
       
            for (var depth:int=minDepth; depth<=maxDepth; depth+=2n){
                val iterations = 1n << (maxDepth - depth + minDepth);
                check = 0n;
            
                for (var i:int = 1n; i<=iterations;i++){
                    check += tree(i,depth).itemCheck() +  tree(-i,depth).itemCheck();
                }
                Console.OUT.println((iterations*2n) + "\t trees of depth " + depth + "\t check: " + check);
            }
            Console.OUT.println("long lived tree of depth " + maxDepth + "\t check: "+ longLivedTree.itemCheck());
            val endtime = System.nanoTime();
            Console.OUT.println("Runtime: " + (endtime - Starttime));
        }
    }

    static def tree(item:int, depth:int) : TreeNode {
        return depth > 0n ? 
        new TreeNode(tree(2n*item-1n, depth-1n), tree(2n*item, depth-1n), item) :
        new TreeNode(null,null,item);
    }

    private static class TreeNode {
        val leftTree:TreeNode;
        val rightTree:TreeNode;
        val item:int;
        def this(left:TreeNode, right:TreeNode, num:int){
            
            leftTree = left;
            rightTree = right;
            item = num;
        }
        def itemCheck() : int {
            return leftTree == null ? item : item + leftTree.itemCheck() - rightTree.itemCheck();
        }
    }
}

