package test;
import uts.UTSTaskFrame;
import uts.UTSTaskBag;
import glb.TaskFrame;
import glb.TaskBag;
public class TestMyUTS {
	/**
	 * If the users' code can pass this test, it is very likely their 
	 * code would work directly on GLB. We want to get to a point 
	 * where if users' code can pass this pattern of test, we can promise
	 * their parallel version of code will work. Essence of code is
	 * from line 24 to line 31:
	 * (1) init task (2) keep spliting and merging back while computing
	 * (3) finish and get result
	 */
	public static def testMyUTSTaskBag(){
		val branchFactor:Int = 4n;
		val seed:Int = 19n;
		val depth:Int = 13n;
		val n:Long = 512L;
		val desiredResult:Long = 264459392L;
		// testing pattern
		val mytask1:TaskFrame[Long] = new UTSTaskFrame(branchFactor, seed, depth);
		mytask1.initTask();	
		while(mytask1.runAtMostNTasks(n)){
			val splitBag:UTSTaskBag = mytask1.getTaskBag().split() as UTSTaskBag;
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
		val mytask:TaskFrame[Long] = new UTSTaskFrame(branchFactor, seed, depth);
		mytask.initTask();
		while(mytask.runAtMostNTasks(n));
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