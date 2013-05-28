/*
 *
 * (C) Copyright IBM Corporation 2006
 *
 *  This file is part of X10 Test.
 *
 */
package montecarlo.parallel.montecarlo;

import x10.util.*;

/**
 * X10 port of montecarlo benchmark from Section 2 of Java Grande Forum Benchmark Suite (Version 2.0).
 *
 * @author Vivek Sarkar (vsarkar@us.ibm.com)
 *
 * Porting issues identified:
 * 3) Remove null checks on non-nullable fields (pathValue, pathDate)
 * 4) Replace "enum" by "e" as a variable name
 * 5) Make first parameter of readRateFile nullable, because one of the calls passes a null value for that parameter
 * 6) No need to extend x10.lang.Object because PathId already does that.
 */
public class RatePath extends PathId {

	//------------------------------------------------------------------------
	// Class variables.
	//------------------------------------------------------------------------

	/**
	 * Class variable, for setting whether to print debug messages.
	 */
	public static val debug: boolean = true;

	/**
	 * The prompt to write before any debug messages.
	 */
	protected static val prompt: String = "RatePath> ";

	/**
	 * Class variable for determining which field in the stock data should be
	 * used.  This is currently set to point to the 'closing price'.
	 */
	public static val datumfield: int = 4;

	/**
	 * Class variable to represent the minimal date, whence the stock prices
	 * appear. Used to trap any potential problems with the data.
	 */
	public static val MINIMUMDATE: int = 19000101;

	/**
	 * Class variable for defining what is meant by a small number, small enough
	 * to cause an arithmetic overflow when dividing.  According to the
	 * Java Nutshell book, the actual range is +/-4.9406564841246544E-324
	 */
	public static val EPSILON: double = 10.0 * Double.MIN_VALUE;

	//------------------------------------------------------------------------
	// Instance variables.
	//------------------------------------------------------------------------

	/**
	 * An instance variable, for storing the rate's path values itself.
	 */
	private var pathValue: Array[double];

	/**
	 * An instance variable, for storing the corresponding date of the datum,
	 * in 'YYYYMMDD' format.
	 */
	private var pathDate: Array[int];

	/**
	 * The number of accepted values in the rate path.
	 */
	private var nAcceptedPathValue: int = 0;

	//------------------------------------------------------------------------
	// Constructors.
	//------------------------------------------------------------------------

	/**
	 * Constructor, where the user specifies the filename in from which the
	 * data should be read.
	 *
	 * @param String filename
	 * @exception DemoException thrown if there is a problem reading in
	 *                          the data file.
	 */
	public def this(var filename: String): RatePath = {
		set_prompt(prompt);
		set_DEBUG(debug);
		readRatesFile(null, filename);
	}

	/**
	 * Constructor, where the user specifies the directory and filename in
	 * from which the data should be read.
	 *
	 * @param String dirName
	 * @param String filename
	 * @exception DemoException thrown if there is a problem reading in
	 *                          the data file.
	 */
	public def this(var dirName: String, var filename: String): RatePath = {
		set_prompt(prompt);
		set_DEBUG(debug);
		readRatesFile(dirName, filename);
	}

	/**
	 * Constructor, for when the user specifies simply an array of values
	 * for the path.  User must also include information for specifying
	 * the other characteristics of the path.
	 *
	 * @param pathValue the array containing the values for the path.
	 * @param name the name to attach to the path.
	 * @param startDate date from which the path is supposed to start, in
	 *        'YYYYMMDD' format.
	 * @param startDate date from which the path is supposed to end, in
	 *        'YYYYMMDD' format.
	 * @param dTime the time interval between successive path values, in
	 *        fractions of a year.
	 */
	public def this(var pathValue: Array[double], var name: String, var startDate: int, var endDate: int, var dTime: double): RatePath = {
		set_name(name);
		set_startDate(startDate);
		set_endDate(endDate);
		set_dTime(dTime);
		set_prompt(prompt);
		set_DEBUG(debug);
		this.pathValue = pathValue;
		this.nAcceptedPathValue = pathValue.size;
	}

	/**
	 * Constructor, for use by the Monte Carlo generator, when it wishes
	 * to represent its findings as a RatePath object.
	 *
	 * @param mc the Monte Carlo generator object, whose data are to
	 *           be copied over.
	 * @exception DemoException thrown if there is an attempt to access
	 *            an undefined variable.
	 */
	public def this(var mc: MonteCarloPath): RatePath = {
		//
		// Fields pertaining to the parent PathId object:
		set_name(mc.get_name());
		set_startDate(mc.get_startDate());
		set_endDate(mc.get_endDate());
		set_dTime(mc.get_dTime());
		//
		// Fields pertaining to RatePath object itself.
		pathValue = mc.get_pathValue();
		nAcceptedPathValue = mc.get_nTimeSteps();
		//
		// Note that currently the pathDate is neither declared, defined,
		// nor used in the MonteCarloPath object.
		pathDate = new Array[int](nAcceptedPathValue);
	}

	/**
	 * Constructor, for when there is no actual pathValue with which to
	 * initialise.
	 *
	 * @param pathValueLegth the length of the array containing the values
	 *        for the path.
	 * @param name the name to attach to the path.
	 * @param startDate date from which the path is supposed to start, in
	 *        'YYYYMMDD' format.
	 * @param startDate date from which the path is supposed to end, in
	 *        'YYYYMMDD' format.
	 * @param dTime the time interval between successive path values, in
	 *        fractions of a year.
	 */
	public def this(var pathValueLength: int, var name: String, var startDate: int, var endDate: int, var dTime: double): RatePath = {
		set_name(name);
		set_startDate(startDate);
		set_endDate(endDate);
		set_dTime(dTime);
		set_prompt(prompt);
		set_DEBUG(debug);
		this.pathValue = new Array[double](pathValueLength);
		this.nAcceptedPathValue = pathValue.size;
	}
	//------------------------------------------------------------------------
	// Methods.
	//------------------------------------------------------------------------

	/**
	 * Routine to update this rate path with the values from another rate
	 * path, via its pathValue array.
	 *
	 * @param operandPath the path value array to use for the update.
	 * @exception DemoException thrown if there is a mismatch between the
	 *            lengths of the operand and target arrays.
	 */
	public def inc_pathValue(var operandPath: Array[double]): void = {
		if (pathValue.size != operandPath.size)
			throw new DemoException("The path to update has a different size to the path to update with!");
		for (var i: int = 0; i<pathValue.size; i++)
			pathValue(i) += operandPath(i);
	}

	/**
	 * Routine to scale this rate path by a constant.
	 *
	 * @param scale the constant with which to multiply to all the path
	 *        values.
	 * @exception DemoException thrown if there is a mismatch between the
	 *            lengths of the operand and target arrays.
	 */
	public def inc_pathValue(var scale: double): void = {
		// (VIVEK) Remove null checks on non-nullable field (pathValue)
		// if (pathValue == null)
		//  throw new DemoException("Variable pathValue is undefined!");
		for (var i: int = 0; i<pathValue.size; i++)
			pathValue(i) *= scale;
	}
	//------------------------------------------------------------------------
	// Accessor methods for class RatePath.
	// Generated by 'makeJavaAccessor.pl' script.  HWY.  20th January 1999.
	//------------------------------------------------------------------------

	/**
	 * Accessor method for private instance variable <code>pathValue</code>.
	 *
	 * @return Value of instance variable <code>pathValue</code>.
	 * @exception DemoException thrown if instance variable <code>pathValue</code> is undefined.
	 */
	public def get_pathValue(): Array[double] = {
		// (VIVEK) Remove null checks on non-nullable field (pathValue)
		//  if (this.pathValue == null)
		// throw new DemoException("Variable pathValue is undefined!");
		return (this.pathValue);
	}

	/**
	 * Set method for private instance variable <code>pathValue</code>.
	 *
	 * @param pathValue the value to set for the instance variable <code>pathValue</code>.
	 */
	public def set_pathValue(var pathValue: Array[double]): void = {
		this.pathValue = pathValue;
	}

	/**
	 * Accessor method for private instance variable <code>pathDate</code>.
	 *
	 * @return Value of instance variable <code>pathDate</code>.
	 * @exception DemoException thrown if instance variable <code>pathDate</code> is undefined.
	 */
	public def get_pathDate(): Array[int] = {
		// (VIVEK) Remove null checks on non-nullable field (pathDate)
		// if (this.pathDate == null)
		//  throw new DemoException("Variable pathDate is undefined!");
		return (this.pathDate);
	}

	/**
	 * Set method for private instance variable <code>pathDate</code>.
	 *
	 * @param pathDate the value to set for the instance variable <code>pathDate</code>.
	 */
	public def set_pathDate(var pathDate: Array[int]): void = {
		this.pathDate = pathDate;
	}
	//------------------------------------------------------------------------

	/**
	 * Method to return the terminal value for a given rate path, as used
	 * in derivative calculations.
	 *
	 * @return The last value in the rate path.
	 */
	public def getEndPathValue(): double = {
		return (getPathValue(pathValue.size-1));
	}

	/**
	 * Method to return the value for a given rate path, at a given index.
	 * <i>One may want to index this in a more user friendly manner!</i>
	 *
	 * @param index the index on which to return the path value.
	 * @return The value of the path at the designated index.
	 */
	public def getPathValue(var index: int): double = {
		return (pathValue(index));
	}

	/**
	 * Method for calculating the returns on a given rate path, via the
	 * definition for the instantaneous compounded return.
	 *       u_i = \ln { \frac { S_i } { S_ { i-1 } } }
	 *
	 * @return the return, as defined.
	 * @exception DemoException thrown if there is a problem with the
	 *                          calculation.
	 */
	public def getReturnCompounded(): ReturnPath = {
		// (VIVEK) Remove null checks on non-nullable field (pathValue)
		//if (pathValue == null || nAcceptedPathValue == 0) { // }
		if (nAcceptedPathValue == 0) {
			throw new DemoException("The Rate Path has not been defined!");
		}
		var returnPathValue: Array[double] = new Array[double](nAcceptedPathValue);
		returnPathValue(0) = 0.0;
		try {
			for (var i: int = 1; i< nAcceptedPathValue; i++) {
				returnPathValue(i) = Math.log(pathValue(i) / pathValue(i-1));
			}
		} catch (var aex: ArithmeticException) {
			throw new DemoException("Error in getReturnLogarithm:"+aex.toString());
		}
		var rPath: ReturnPath = new ReturnPath(returnPathValue, nAcceptedPathValue,
				ReturnPath.COMPOUNDED);
		//
		// Copy the PathId information to the ReturnPath object.
		rPath.copyInstanceVariables(this);
		rPath.estimatePath();
		return (rPath);
	}

	/**
	 * Method for calculating the returns on a given rate path, via the
	 * definition for the instantaneous non-compounded return.
	 *       u_i = \frac { S_i - S_ { i-1 } } { S_i }
	 *
	 * @return the return, as defined.
	 * @exception DemoException thrown if there is a problem with the
	 *                          calculation.
	 */
	public def getReturnNonCompounded(): ReturnPath = {
		// (VIVEK) Remove null checks on non-nullable field (pathValue)
		//if (pathValue == null || nAcceptedPathValue == 0) { // }
		if (nAcceptedPathValue == 0) {
			throw new DemoException("The Rate Path has not been defined!");
		}
		var returnPathValue: Array[double] = new Array[double](nAcceptedPathValue);
		returnPathValue(0) = 0.0;
		try {
			for (var i: int = 1; i< nAcceptedPathValue; i++) {
				returnPathValue(i) = (pathValue(i) - pathValue(i-1))/pathValue(i);
			}
		} catch (var aex: ArithmeticException) {
			throw new DemoException("Error in getReturnPercentage:"+aex.toString());
		}
		var rPath: ReturnPath = new ReturnPath(returnPathValue, nAcceptedPathValue,
				ReturnPath.NONCOMPOUNDED);
		//
		// Copy the PathId information to the ReturnPath object.
		rPath.copyInstanceVariables(this);
		rPath.estimatePath();
		return (rPath);
	}

	//------------------------------------------------------------------------
	// Private methods.
	//------------------------------------------------------------------------

	/**
	 * Method for reading in data file, in a given format.
	 * Namely:
	 <pre>
	 881003,0.0000,14.1944,13.9444,14.0832,2200050,0
	 881004,0.0000,14.1668,14.0556,14.1668,1490850,0
	 ...
	 990108,35.8125,36.7500,35.5625,35.8125,4381200,0
	 990111,35.8125,35.8750,34.8750,35.1250,3920800,0
	 990112,34.8750,34.8750,34.0000,34.0625,3577500,0
	 </pre>
	 * <p>Where the fields represent, one believes, the following:
	 * <ol>
	 *   <li>The date in 'YYMMDD' format</li>
	 *   <li>Open</li>
	 *   <li>High</li>
	 *   <li>Low</li>
	 *   <li>Last</li>
	 *   <li>Volume</li>
	 *   <li>Open Interest</li>
	 * </ol>
	 * One will probably make use of the closing price, but this can be
	 * redefined via the class variable <code>DATUMFIELD</code>.  Note that
	 * since the read in data are then used to compute the return, this would
	 * be a good place to trap for zero values in the data, which will cause
	 * all sorts of problems.
	 *
	 * @param dirName the directory in which to search for the data file.
	 * @param filename the data filename itself.
	 * @exception DemoException thrown if there was a problem with the data
	 *                          file.
	 */
	private def readRatesFile(var ndirName: String, var filename: String): void = {
		var dirName: String = ndirName as String;
		var ratesFile: x10.io.File = new File(dirName, filename);
		var inn: x10.io.BufferedReader;
		if (! ratesFile.canRead()) {
			throw new DemoException("Cannot read the file "+ratesFile.toString());
		}
		try {
			inn = new BufferedReader(new FileReader(ratesFile));
		} catch (var fnfex: FileNotFoundException) {
			throw new DemoException(fnfex.toString());
		}
		//
		// Proceed to read all the lines of data into a Vector object.
		var iLine: int = 0;
		var initNlines: int = 100;
		var nLines: int = 0;

		var naLine: String;
		var allLines: x10.util.Vector = new Vector(initNlines);
		try {
			while ((naLine = inn.readLine()) != null) {
				iLine++;
				//
				// Note, I'm not entirely sure whether the object passed in is copied
				// by value, or just its reference.
				allLines.addElement(naLine as String);
			}
		} catch (var ioex: IOException) {
			throw new DemoException("Problem reading data from the file "+ioex.toString());
		}
		nLines = iLine;
		//
		// Now create an array to store the rates data.
		this.pathValue = new Array[double](nLines);
		this.pathDate  = new Array[int](nLines);
		nAcceptedPathValue = 0;
		iLine = 0;
		for (var e: x10.util.Enumeration = allLines.elements(); e.hasMoreElements();) {
			var aLine: String = e.nextElement() as String;
			var field: Rail[String] = Utilities.splitString(",", aLine);
			var aDate: int = Integer.parseInt("19"+field(0));
			//
			// static double Double.parseDouble() method is a feature of JDK1.2!
			var aPathValue: double = Double.valueOf(field(datumfield));
			if ((aDate <= MINIMUMDATE) || (Math.abs(aPathValue) < EPSILON)) {
				dbgPrintln("Skipped erroneous data in "+filename+" indexed by date = "+field(0)+".");
			} else {
				pathDate(iLine) = aDate;
				pathValue(iLine) = aPathValue;
				iLine++;
			}
		}
		//
		// Record the actual number of accepted data points.
		nAcceptedPathValue = iLine;
		//
		// Now to fill in the structures from the 'PathId' class.
		set_name(ratesFile.getName());
		set_startDate(pathDate(0));
		set_endDate(pathDate(nAcceptedPathValue-1));
		set_dTime((1.0/365.0) as double);
	}
}
