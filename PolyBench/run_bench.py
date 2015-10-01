import os, sys, subprocess, re, glob, signal
import color_printer
import shutil
import util

repeat = 1 # change me to get different repeat times

benchmarks = [ # change me to run more or less benchmark programs (if they are runnable)
		"datamining/correlation/",
		"datamining/covariance/",
		"linear-algebra/kernels/2mm/",
		"linear-algebra/kernels/3mm/",
		"linear-algebra/kernels/atax/",
		"linear-algebra/kernels/bicg/",
		"linear-algebra/kernels/cholesky/",
		"linear-algebra/kernels/doitgen/",
		"linear-algebra/kernels/gemm/",
		"linear-algebra/kernels/gemver/",
		"linear-algebra/kernels/gesummv/",
		"linear-algebra/kernels/mvt/",
		"linear-algebra/kernels/symm/",
		"linear-algebra/kernels/syr2k/",
		"linear-algebra/kernels/syrk/",
		"linear-algebra/kernels/trisolv/",
		# trmm in x10 creates tons of activities and results in a horrible execution time.
		#"linear-algebra/kernels/trmm/",
		"linear-algebra/solvers/durbin/",
		"linear-algebra/solvers/dynprog/",
		"linear-algebra/solvers/gramschmidt/",
		"linear-algebra/solvers/lu/", 
		"linear-algebra/solvers/ludcmp/",
		#too slow in x10
		#"medley/floyd-warshall/",
		"medley/reg_detect/",
		"stencils/adi/",
		"stencils/fdtd-apml/",
		"stencils/fdtd-2d/",
		"stencils/jacobi-1d-imper/",
		"stencils/jacobi-2d-imper/",
		#"stencils/seidel-2d/",
		]

polyopt_options = [
		"--polyopt-fixed-tiling",
		"--polyopt-parametric-tiling",
		"--polyopt-parallel-only",
		]

#polybench_c_path = "../polybench-c-large-time/"

def signal_handler(signal, frame):
	color_printer.print_warning("Terminated by User. The measure isn't completed!")
	sys.exit(0)

def execute(cmd, handle_err=False):
	print "executing %s..."%(" ".join(cmd))
	sp = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	out, err = sp.communicate()
	if handle_err:
		if sp.returncode == 0:
			color_printer.print_ok_green("looks good...")
		else:
			color_printer.print_fail("command \"%s\" executed failed!" % " ".join(cmd))
			print out
			print err
	return out, err

def run_x10(dir):
	if os.path.exists(dir):
		out, err = execute([dir, "LARGE_DATASET"])
	else:
		return dir, 0
	res = float(re.search("Elapsed time=\s+([0-9]+)", out).group(1)) / 1000
	print "x10: " + str(res) + " (s)"
	return dir, res

#def run_c(dir):
#	if os.path.exists(dir):
#		out, err = execute([dir])
#	else:
#		return dir, 0
#	out = out.rstrip()
#	print "c: " + out + " (s)"
#	return dir, float(out)

def repeat_execute(fun, dir):
	res = []
	for i in range(repeat):
		res.append(fun(dir))
	#f = open(os.path.basename(dir) + "/time.dat", "b")
	lines = util.file_as_lines(os.path.basename(dir) + "/time.dat")
	print lines
	lines += [str(s)+"\n" for s in res];
	print lines
	#f.write("".join([str(s)+"\n" for s in res]))
	util.lines_to_file(os.path.basename(dir) + "/time.dat", lines)

def compare(dir):
	sources = os.listdir(dir)
	for s in sources:
		fname, ext = os.path.splitext(s)
		if ext == ".out" and (not fname == "a"):
			bench_file = s
			bench_name = fname
			c_bench_file = dir.split("/")[-2] + ".out"
			break
	else:
		return
	color_printer.print_bold("[WORKING] running %s..."%(bench_name))
	total_res = []
	for i in range(repeat):
		print "iteration %d..."%(i+1)
		res = []
		# run c standard version:
		#res.append(run_c(polybench_c_path + dir + c_bench_file))
		# run x10 standard version:
		res.append(run_x10(dir + bench_file))
		for opt in polyopt_options:
			color_printer.print_bold("[WORKING] running subversion compiled using %s..."%(opt))
			target_path = dir + re.match("--polyopt-([a-zA-Z0-9\-_]+)", opt).group(1).replace("-", "_")
			# run c version firstly
			#res.append(run_c(polybench_c_path + target_path + "/" + c_bench_file))

			# run_x10 
			target_bench = target_path + "/" + bench_file
			if not os.path.exists(target_bench):
				color_printer.print_warning("cannot check program %s, this program haven't been compiled by x10c++!"%(target_bench))
				continue
			res.append(run_x10(target_bench))
		total_res.append(res)
	res_d = {}
	for res in total_res:
		for dir, time in res:
			if dir in res_d:
				res_d[dir].append(time)
			else:
				res_d[dir] = [time]
	#print res_d
	for dir, times in res_d.iteritems():
		try:
			lines = util.file_as_lines(os.path.dirname(dir) + "/time.dat")
		except IOError:
			lines = []
		lines += [str(s)+"\n" for s in times];
		util.lines_to_file(os.path.dirname(dir) + "/time.dat", lines)

if __name__ == '__main__':
	signal.signal(signal.SIGINT, signal_handler)

	if len(sys.argv) > 1:
		compare(sys.argv[2])
		exit()
	else:
		for dir in benchmarks:
			compare(dir)
