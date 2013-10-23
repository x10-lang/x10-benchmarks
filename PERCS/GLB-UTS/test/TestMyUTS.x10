package test;
import myuts.UTSTaskFrame;
import myuts.UTSTaskBag;
import myuts.UTSTreeNode;
import core.TaskFrame;
import core.TaskBag;
public class TestMyUTS {
	
	public static def testMyUTSTaskBag(){
		val branchFactor:Int = 4n;
		val seed:Int = 19n;
		val depth:Int = 13n;
		val n:Long = 512L;
		val desiredResult:Long = 264459392L;
		// testing pattern
		val mytask1:TaskFrame[UTSTreeNode, Long] = new UTSTaskFrame(branchFactor, seed, depth);
		mytask1.initTask();	
		while(mytask1.runAtMostNTask(n)){
			val splitBag:UTSTaskBag[UTSTreeNode] = mytask1.getTaskBag().split() as UTSTaskBag[UTSTreeNode];
			if(splitBag !=null){
				mytask1.getTaskBag().merge(splitBag);
			}
		}
		result:Long = mytask1.getResult();	
		// end of testing pattern
		assert(result == desiredResult);
		Console.OUT.println("taskbag test passed.");
	}
	public static def testMyUTSTaskFrame(){
		val branchFactor:Int = 4n;
		val seed:Int = 19n;
		val depth:Int = 13n;
		val n:Long = 512L;
		val desiredResult:Long = 264459392L;
		
		// calling sequence to do the testing: constructor-->initTask-->while(runAtMostN())-->getResult()
		val mytask:TaskFrame[UTSTreeNode, Long] = new UTSTaskFrame(branchFactor, seed, depth);
		mytask.initTask();
		while(mytask.runAtMostNTask(n));
		result:Long = mytask.getResult();
		// end of calling sequence
	
		assert(result == desiredResult);
		Console.OUT.println("taskframe test passed.");
	}
	
	public static def main(args:Rail[String]){
		testMyUTSTaskFrame();
		testMyUTSTaskBag();
	}
}