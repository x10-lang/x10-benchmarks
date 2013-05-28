/** 
* The Computer Language Benchmarks Game
* http://shootout.alioth.debian.org/
* 
* Based on Java-6 version, Jarkko Miettinen
* 
* v2: v1 + general clean up and use x10 idioms
*/
class binarytrees {
    private static val minDepth = 4;

    public static def main(args: Array[String](1){rail}) {
    	for(var o:int = 0; o < 10; o++){
    	val Starttime = System.nanoTime();
        val n = args.size > 0 ? Int.parse(args(0)) : 0; 

        val maxDepth = (minDepth + 2 > n) ? minDepth + 2 : n;
        val stretchDepth = maxDepth + 1;

        var check:int = tree(0,stretchDepth).itemCheck();
        
        Console.OUT.println("stretch tree of depth "+stretchDepth+"\t check: " + check);

        val longLivedTree = tree(0,maxDepth);
       
       for (var depth:int=minDepth; depth<=maxDepth; depth+=2){
           val iterations = 1 << (maxDepth - depth + minDepth);
            check = 0;
            
            for (var i:int = 1; i<=iterations;i++){
                check += tree(i,depth).itemCheck() +  tree(-i,depth).itemCheck();
            }
            
      
        Console.OUT.println((iterations*2) + "\t trees of depth " + depth + "\t check: " + check);
        }
        Console.OUT.println("long lived tree of depth " + maxDepth + "\t check: "+ longLivedTree.itemCheck());
        val endtime = System.nanoTime();
        Console.OUT.println("Runtime: " + (endtime - Starttime));
    }
    }

    static def tree(item:int, depth:int) : TreeNode {
        return depth > 0 ? 
        new TreeNode(tree(2*item-1, depth-1), tree(2*item, depth-1), item) :
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

