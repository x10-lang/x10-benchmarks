import x10.util.Stack;
import x10.util.Random;
import x10.lang.Math;

final class BinomialState {
	final static class FixedSizeStack[T] {
		val data:Rail[T];
	    var last:Int;
	    val size:Int;
		def this(n:Int, t:T) {
			data = Rail.make[T](n, (i:Int) => t);
			last = -1;
			size= n;
		}
		def empty():Boolean= last < 0;
		def pop():T {
			if (empty())
				throw new Error("Popping an empty stack");
			val result = data(last);
			last--;
			return result;
		}
		def push(t:T) {
			if (last >= size-1) {
				Console.OUT.print("In stack (limit=" + size + ",size=" + size() + ") unanticipated thief" + 
						t + " at " + here.id + ", already has: " );
				for (thief in data) {
					Console.OUT.print("" + thief);
				}
				Console.OUT.println();
				throw new Error("Pushing onto a full stack");
			}
			last++;
			data(last)=t;
		}
		def size():Int=last+1;
		
	}
    val thieves:FixedSizeStack[Int]!;
	
	val width:Int;
	val stack = new Stack[UTS.SHA1Rand]();
	// My outgoing lifelines.
    val myLifelines:ValRail[Int];
	// Which of the lifelines have I actually activated?
	val lifelinesActivated: Rail[Boolean];

	val q:Long, m:Int, k:Int, nu:Int, l:Int;
	val z:Int;
	val logEvents:Boolean;
	val myRandom = new Random();
    public val counter = new Counter();
	static type PLH= PlaceLocalHandle[BinomialState];
	static type SHA1Rand = UTS.SHA1Rand;
	var active:Boolean=false;

	/** Initialize the state. Executed at all places when executing the 
	 PlaceLocalHandle.make command in main (of UTS).
	 */
	public def this (q:Long, m:Int, k:Int, nu:Int, w:Int, e:Boolean, l:Int,
                   lifelineNetwork:ValRail[Int]) {
		this.q = q; this.m = m; this.k=k; this.nu=nu; this.l = l;
        this.myLifelines = lifelineNetwork;
        this.z = lifelineNetwork.length; // assume symmetric.
		width=w;
		logEvents=e;
		thieves = new FixedSizeStack[Int](z, 0);
		lifelinesActivated = Rail.make[Boolean](Place.MAX_PLACES, (Int)=>false);
		// printLifelineNetwork();
	}

  def printLifelineNetwork () {
    Console.OUT.print (here.id + " =>");
    for (var i:Int=0; i<myLifelines.length(); ++i) 
      if (-1 != myLifelines(i)) Console.OUT.print  (" " + myLifelines(i));
      else Console.OUT.print (" X");
    Console.OUT.println ();
  }

	def event(s:String) {
		event(logEvents, s);
	}

	def event(verbose:Boolean, s:String) {
		if (verbose)
			Console.OUT.println("[Place(" + here.id+"), at " 
					+ System.nanoTime() + "] " + s);
	}

	/** Check if the current node (governed by the SHA1Rand state) has any
	 children. If so, push it onto the local stack.
	 */
	final def processSubtree (rng:SHA1Rand) {
		processSubtree(rng, (rng() < q) ? m : 0);
	}

	/** Same as above, but called when we have already made a decision that
	 there are going to be this "numChildren" children. Its useful to 
	 split the functionality from the function (processSubtree) above as 
	 in some cases (for eg., processing the root node), we just want to 
	 directly create children instead of basing the decision off of a 
	 random number state.
	 */
	final def processSubtree (rng:SHA1Rand, numChildren:Int) {
		counter.nodesCounter++;
		// Iterate over all the children and push on stack
		for (var i:Int=0 ; i<numChildren ; ++i) 
			stack.push(SHA1Rand(rng, i));
	}
	final def processLoot(loot: ValRail[SHA1Rand], lifeline:Boolean) {
		if (loot != null) {
			counter.incRx(lifeline, loot.length);
			val time = System.nanoTime();
			for (r in loot) 
				processSubtree(r);
			counter.incTimeComputing(System.nanoTime() - time);
		}	
	}
	final def processAtMostN(n:Int) {
		val time = System.nanoTime();
		for (var count:Int=0; count < n; count++) {
			val e = stack.pop();
			processSubtree(e);
		}
		counter.incTimeComputing(System.nanoTime() - time);
	}

	/** Return an array of "k" elements popped from the local stack.*/
	//final def pop(k:Int) = ValRail.make[SHA1Rand](k, (int)=> stack.pop());

  /** A trivial function to calculate minimum of 2 integers */
	def min(i:int,j:int) = i < j ? i : j;

	/** Go through each element in the stack, process it (generate its
	 children, and add them to the stack) until there is nothing left
	 on the stack. At this point, attempt to steal. If nothing can be 
	 stolen, terminate for now. Also, after processing a particular 
	 number of nodes, check if there are any outstanding messages to
	 handle and also, distribute a chunk of the local stack (work) to 
	 our lifeline buddy.
	 */
	final def processStack(st:PLH) {
		while (stack.size() > 0) {
			var n:Int = min(stack.size(), nu);
			while (n > 0) {
				processAtMostN(n);
				Runtime.probe();
				distribute(st, 1);
				n = min(stack.size(), nu);
			}
			val loot = attemptSteal(st);
			processLoot(loot,false);
		}
	    event("Finished main loop.");
	}

  /** If our buddy/buddies have requested a lifeline, and we have ample supply 
   of nodes, give him half (i.e, launch a remote async).
	 */
	def distribute(st:PLH, depth:Int) {
		while (stack.size() > 1 && thieves.size() > 0) {
			val thief=thieves.pop();
			val numToSteal = stack.size()/2;
			val loot = stack.pop(numToSteal);
			counter.incTxNodes(numToSteal);
			event("Distributing " + loot.length() + " to " + thief);
		    val victim = here.id;
		    // During this communication, you may process (a)
		    // incoming thefts, this reduces stack, (b) incoming
		    // distributions, this increases stack.
		    async (Place(thief)) 
		      st().launch(st, false, loot, depth, victim);
		}
  }

	/** This is the code invoked locally by each node when there are no 
	 more nodes left on the stack. In other words, this function is 
	 the basis of all pull-based stealing. The push based stealing 
	 happens through the lifeline system. First, we attempt to get 
	 work from randomly chosen neighbors (for a certain number of 
	 tries). If we are not successful, we invoke our lifeline system.
	 */
	def attemptSteal(st:PLH):ValRail[SHA1Rand] {
		event("Attempt steal");
		val P = Place.MAX_PLACES;
		if (P == 1) return null;
		val p = here.id;
		for (var i:Int=0; i < width && stack.size()==0; i++) {
		   var q_:Int = 0;
		   while((q_ =  myRandom.nextInt(P)) == p) ;
		   val q = q_;
		   counter.incStealsAttempted();
		   event("Stealing from " + q);
		   // Potential communication attempt.
		   // May receive incoming thefts or distributions.
		   val loot = at (Place(q)) st().trySteal(p);
		   if (loot != null) {
			  event("Steal succeeded with " + 
					(loot == null ? 0 : loot.length()) + " items");
			  return loot;
		   }
		}
		event("No loot; establishing lifeline(s).");

		// resigned to make a lifeline steal from one of our lifelines.
		var loot:ValRail[SHA1Rand] = null;
		for (var i:Int=0; i<myLifelines.length() && stack.size()==0; ++i) {
			val lifeline:Int = myLifelines(i);
		    if (-1 != lifeline && ! lifelinesActivated(lifeline) ) {
		    	 lifelinesActivated(lifeline) = true;
			   loot = at(Place(lifeline)) st().trySteal(p, true);
			   event("Lifeline steal result " + (loot==null ? 0 : loot.length()));
			   if (null!=loot) {
				   lifelinesActivated(lifeline) = false;
				   break;
			   }
			  
		    }
		 }
         return loot;
	}

	/** Try to steal from the local stack --- invoked by either a 
	 theif at a remote place using asyncs (during attemptSteal) 
	 or by the owning place itself when it wants to give work to 
	 a fallen buddy.
	 */
    def trySteal(p:Int):ValRail[SHA1Rand]=trySteal(p, false);
	def trySteal(p:Int, isLifeLine:Boolean) : ValRail[SHA1Rand] {
		counter.incStealsReceived();
		val length = stack.size();
		if (length <= 2) {
			if (isLifeLine)
		      thieves.push(p);
			event("Returning null");
			return null;
		}
		val numSteals = length/2;
		counter.incTxNodes(numSteals);
		return stack.pop(numSteals);
	}

	def launch(st:PLH, init:Boolean, loot:ValRail[SHA1Rand], depth:Int, source:Int) {
		try {
			lifelinesActivated(source) = false;
			if (active) {
				processLoot(loot, true);
				assert (! init);
				// Now you can return, the outer activity will handle the data on the stack.
			    if (depth > 0) 
					  distribute(st, depth+1);
				return;
			}
			active=true;
		    counter.startLive();
		    counter.updateDepth(depth);
		    processLoot(loot, true);
		    if (depth > 0) 
			  distribute(st, depth+1);
		    processStack(st);
		    counter.stopLive();
		    active=false;
		} catch (v:Throwable) {
			Console.OUT.println("Exception at " + here);
			v.printStackTrace();
		} catch (v:Error) {
			Console.OUT.println("Exception at " + here);
			v.printStackTrace();
		}
	}

	/** Called only for the root node. Processes all the children of 
	 the root node and then proceeds to divide these children up 
	 evenly amongst all the places. This is the bootstrap mechanism
	 for distributed UTS.
	 */
	def main (st:PLH, 
            b0:Int, 
            rng:SHA1Rand) {
		val P=Place.MAX_PLACES;
		event("Start main finish");
		counter.lastTimeStamp = System.nanoTime();
		finish {
			event("Launch main");
			processSubtree(rng, b0);
			val lootSize = stack.size()/P;
			for (var pi:Int=1 ; pi<P ; ++pi) {
				val loot = stack.pop(lootSize);
				async (Place(pi))
				   st().launch(st, true, loot, 0, 0);
				counter.incTxNodes(lootSize);
			}
			processStack(st);
			event("Finish main");
		} 
		event("End main finish");
	}
}

