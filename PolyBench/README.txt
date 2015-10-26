* * * * * * * * * * *
* PolyBench/X10 1.0 *
* * * * * * * * * * *

----------------------
* System Requirements:
----------------------
- python 2.4-2.7
- gcc, xlc(V12.1)
- x10 compiler and runtime installed and exported in PATH

-------------------------
* Change benchmark modes:
-------------------------

** There are two modes of benchmark, 
one is for checking correctness of each benchmark program, which will output computing result.
Another one is for monitoring executing time, which will output executing time in micro-second.
You can use:

$> python toggle_print.py

to toggle_print between these two modes.
The default mode is time monitoring mode.

-------------------
* Compile commands:
-------------------

** To compile a single benchmark:
---------------------------------

$> x10c++ -O -NO_CHECKS -define **THE_DATASET** **THE_BENCHMARK_FILE(.x10)**

** To compile all benchmarks:
-----------------------------

$> python make.py

The script compiles each benchmark programs with LARGE_DATASET, you may change the source code of make.py to use different datasets.
The executable files exist in the same directories of their source code files, namely BENCHMARK_NAME.out.

-------------------
* Running commands:
-------------------

** To specify the number of threads used by x10 runtime for parallel computing:
-------------------------------------------------------------------------------
export X10_MAX_THREADS=N
export X10_NTHREADS=N

** To run a single compiled benchmark:
--------------------------------------

$> ./BENCHMARK_NAME.out

** To run all compiled benchmarks:
----------------------------------

$> python run_bench.py

NOTE that this script must be executed in time monitoring mode.
The script run each benchmark program 1 time by default. The execution time will be written in time.dat in each benchmark directory.
You can specify each benchmark program should be executed or not in the head of run_bench.py.
You can use 

$> for i in {1..N}; do python run_bench.py; done

to run benchmarks for several times. The results will be appended to original time.dat file.
Don't forget to delete old time.dat file if you want to record only new data.

-------------
* Notes
-------------
Please note that the input sizes in PolyBench/X10 suite are partly different
from those in other implementations of PolyBench in order to have at least
a few seconds for the execution time in each benchmark. 

--------------
* KNOWN ISSUES
--------------
- Trmm and Floyd_warshall are not suitable for parallelism, and may take tons of time. Comment them out in run_bench.py or adjust the input size in the source code if necessary.
- Seidel-2d takes huge time to compile, you may remove it out of PolyBench/X10 if you want.
