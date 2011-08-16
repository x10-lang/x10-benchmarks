/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
package montecarlo.distributed.montecarlo;


/**
 * X10 port of montecarlo benchmark from Section 3 of Java Grande Forum Benchmark Suite (Version 2.0).
 *
 *  SERIAL VERSION
 *
 * @author Vivek Sarkar (vsarkar@us.ibm.com)
 *
 * Porting issues identified:
 *
 * 2) Add nullable ToInitAllTasks type static valructor for declaration of
 *    initAllTasks, and cast to non-nullable ToInitAllTasks when
 *    passing initAllTasks as a parameter.
 */
public class AppDemo extends Universal {
	//------------------------------------------------------------------------
	// Class variables.
	//------------------------------------------------------------------------

	public static val JGFavgExpectedReturnRateMC: Double = 0.0;
	public static def JGFavgExpectedReturnRateMC(): double = { return JGFavgExpectedReturnRateMC; }

	/**
	 * A class variable.
	 */
	public static val DEBUG: boolean = true;

	/**
	 * The prompt to write before any debug messages.
	 */
	protected static val prompt: String = "AppDemo> ";

	public static val Serial: int = 1;
	//------------------------------------------------------------------------
	// Instance variables.
	//------------------------------------------------------------------------

	/**
	 * Directory in which to find the historical rates.
	 */
	private var dataDirname: String;

	/**
	 * Name of the historical rate to model.
	 */
	private var dataFilename: String;

	/**
	 * The number of time-steps which the Monte Carlo simulation should
	 * run for.
	 */
	private var nTimeStepsMC: int = 0;

	/**
	 * The number of Monte Carlo simulations to run.
	 */
	private var nRunsMC: int = 0;

	/**
	 * The default duration between time-steps, in units of a year.
	 */
	private var dTime: double = 1.0/365.0;

	/**
	 * Flag to determine whether initialisation has already taken place.
	 */
	private var initialised: boolean = false;

	/**
	 * Variable to determine which deployment scenario to run.
	 */
	private var runMode: int;
	private var D: Dist(1);
	private var tasks: DistArray[ToTask];
	private val expectedReturnRate: DistArray[double](1);
	private val volatility: DistArray[double];
	public def this(var dataDirname: String, var dataFilename: String, var nTimeStepsMC: int, var nRunsMC: int): AppDemo = {
		this.dataDirname    = dataDirname;
		this.dataFilename   = dataFilename;
		this.nTimeStepsMC   = nTimeStepsMC;
		this.nRunsMC        = nRunsMC;
		this.initialised    = false;
		D = Dist.makeBlock(0..(nRunsMC-1));
		expectedReturnRate = DistArray.make[double](D);
		volatility = DistArray.make[double](D);
		set_prompt(prompt);
		set_DEBUG(DEBUG);
	}

	/**
	 * Initialisation and Run methods.
	 */
	var psMC: PriceStock;
	var pathStartValue: double = 100.0;
	var avgExpectedReturnRateMC: double = 0.0;
	var avgVolatilityMC: double = 0.0;

	var initAllTasks: ToInitAllTasks = null;

	/**
	 * Single point of contact for running this increasingly bloated
	 * class.  Other run modes can later be defined for whether a new rate
	 * should be loaded in, etc.
	 * Note that if the <code>hostname</code> is set to the string "none",
	 * then the demonstrator runs in purely serial mode.
	 */
	public def initSerial(): void = {
		try {
			//
			// Measure the requested path rate.
			var rateP: RatePath = new RatePath(dataDirname, dataFilename);
			rateP.dbgDumpFields();
			var returnP: ReturnPath = rateP.getReturnCompounded();
			returnP.estimatePath();
			returnP.dbgDumpFields();
			var expectedReturnRate: double = returnP.get_expectedReturnRate();
			var volatility: double = returnP.get_volatility();
			//
			// Now prepare for MC runs.
			initAllTasks = new ToInitAllTasks(returnP, nTimeStepsMC,
					pathStartValue);
			var slaveClassName: String = "MonteCarlo.PriceStock";
			//
			// Now create the tasks.
			initTasks(nRunsMC);
			//
		} catch (var demoEx: DemoException) {
			dbgPrintln(demoEx.toString());
			//System.exit(-1);
		}
	}

	public def runSerial(): void = {
		val t: ToInitAllTasks = initAllTasks as ToInitAllTasks;
		finish ateach ([i]: Point in expectedReturnRate) {
			var ps: PriceStock = new PriceStock();
			ps.setInitAllTasks(t);
			ps.setTask(tasks(i));
			ps.run();
			var r: ToResult = ps.getResult() as ToResult;
			expectedReturnRate(i) = r.get_expectedReturnRate();
			volatility(i) = r.get_volatility();
		};
	}

	public def processSerial(): void = {
		//
		// Process the results.
		try {
			processResults();
		} catch (var demoEx: DemoException) {
			dbgPrintln(demoEx.toString());
			//System.exit(-1);
		}
	}

	//------------------------------------------------------------------------

	/**
	 * Generates the parameters for the given Monte Carlo simulation.
	 *
	 * @param nRunsMC the number of tasks, and hence Monte Carlo paths to
	 *        produce.
	 */
	private def initTasks(var nRunsMC: int): void = {
		tasks = DistArray.make[ToTask](D, ([i]: Point): ToTask => { return new ToTask("MC run " + i, i as long*11); });
	}

	/**
	 * Method for doing something with the Monte Carlo simulations.
	 * It's probably not mathematically correct, but shall take an average over
	 * all the simulated rate paths.
	 *
	 * @exception DemoException thrown if there is a problem with reading in
	 *            any values.
	 */
	private def processResults(): void = {
		var avgExpectedReturnRateMC: double = expectedReturnRate.reduce((a:double, b:double)=>a+b, 0 as double)/nRunsMC;
		var avgVolatilityMC: double = volatility.reduce((a:double, b:double)=>a+b,0 as double)/nRunsMC;
		/*
		 * The other computations are not actually used. But if needed here
		 * is how they would be represented:
		 */
		/*
		final double[.] runERR = expectedReturnRate.scan(doubleArray.add, 0);
		final double[.] runVolatility = volatility.scan(doubleArray.add, 0);
		finish ateach (point [i] : expectedReturnRate) {
			runERR[i] /= ((double)(i+1));
			runVolatility[i] /= ((double) (i+1));
		}
		// Paths can be averaged by sum-reducing the distributed array of paths
		// with a custom sum() method that adds path components pointwise, and then
		// scaling with 1/nRunsMC.
		*/
		JGFavgExpectedReturnRateMC = avgExpectedReturnRateMC;

		//dbgPrintln("Average over "+nRunsMC+": expectedReturnRate = "+
		//		avgExpectedReturnRateMC+" volatility = "+avgVolatilityMC + JGFavgExpectedReturnRateMC);
	}

	//
	//------------------------------------------------------------------------
	// Accessor methods for class AppDemo.
	// Generated by 'makeJavaAccessor.pl' script.  HWY.  20th January 1999.
	//------------------------------------------------------------------------

	/**
	 * Accessor method for private instance variable <code>dataDirname</code>.
	 * @return Value of instance variable <code>dataDirname</code>.
	 */
	public def get_dataDirname(): String = {
		return (this.dataDirname);
	}

	/**
	 * Set method for private instance variable <code>dataDirname</code>.
	 * @param dataDirname the value to set for the instance variable <code>dataDirname</code>.
	 */
	public def set_dataDirname(var dataDirname: String): void = {
		this.dataDirname = dataDirname;
	}

	/**
	 * Accessor method for private instance variable <code>dataFilename</code>.
	 * @return Value of instance variable <code>dataFilename</code>.
	 */
	public def get_dataFilename(): String = {
		return (this.dataFilename);
	}

	/**
	 * Set method for private instance variable <code>dataFilename</code>.
	 * @param dataFilename the value to set for the instance variable <code>dataFilename</code>.
	 */
	public def set_dataFilename(var dataFilename: String): void = {
		this.dataFilename = dataFilename;
	}

	/**
	 * Accessor method for private instance variable <code>nTimeStepsMC</code>.
	 * @return Value of instance variable <code>nTimeStepsMC</code>.
	 */
	public def get_nTimeStepsMC(): int = {
		return (this.nTimeStepsMC);
	}

	/**
	 * Set method for private instance variable <code>nTimeStepsMC</code>.
	 * @param nTimeStepsMC the value to set for the instance variable <code>nTimeStepsMC</code>.
	 */
	public def set_nTimeStepsMC(var nTimeStepsMC: int): void = {
		this.nTimeStepsMC = nTimeStepsMC;
	}

	/**
	 * Accessor method for private instance variable <code>nRunsMC</code>.
	 * @return Value of instance variable <code>nRunsMC</code>.
	 */
	public def get_nRunsMC(): int = {
		return (this.nRunsMC);
	}

	/**
	 * Set method for private instance variable <code>nRunsMC</code>.
	 * @param nRunsMC the value to set for the instance variable <code>nRunsMC</code>.
	 */
	public def set_nRunsMC(var nRunsMC: int): void = {
		this.nRunsMC = nRunsMC;
	}

	/**
	 * Accessor method for private instance variable <code>tasks</code>.
	 * @return Value of instance variable <code>tasks</code>.
	 */
	public def get_tasks(): DistArray[ToTask] = {
		return (this.tasks);
	}

	/**
	 * Set method for private instance variable <code>tasks</code>.
	 * @param tasks the value to set for the instance variable <code>tasks</code>.
	 */
	public def set_tasks(var tasks: DistArray[ToTask]): void = {
		this.tasks = tasks;
	}

	/**
	 * Accessor method for private instance variable <code>results</code>.
	 * @return Value of instance variable <code>results</code>.
	 */
	/*
	public Vector get_results() {
		return (this.results);
	}
	*/

	/**
	 * Set method for private instance variable <code>results</code>.
	 *
	 * @param results the value to set for the instance variable <code>results</code>.
	 */
	/*
	public void set_results(Vector results) {
		this.results = results;
	}
	*/
	//------------------------------------------------------------------------
}
