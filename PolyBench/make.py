import os, sys, subprocess, re, glob
import color_printer

benchmark_directories = [
		"datamining/",
		"linear-algebra/kernels/",
		"linear-algebra/solvers/",
		"medley/",
		"stencils/"
		]

polyopt_options = [
		"--polyopt-fixed-tiling",
		"--polyopt-parametric-tiling",
		"--polyopt-parallel-only",
		]

polyopt_bin = "PolyOpt"
x10cpp_opt = ["x10c++", "-O", "-NO_CHECKS", "-report", "postcompile=1", "-define", "LARGE_DATASET"]

def execute(cmd, handle_err=False):
	sp = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	print " ".join(cmd)
	out, err = sp.communicate()
	if handle_err:
		if sp.returncode == 0:
			color_printer.print_ok_green("looks good...")
		else:
			color_printer.print_fail("command \"%s\" executed failed!" % " ".join(cmd))
			print out
			print err
	return out, err

def poly_opt_compile(dir):
	sources = os.listdir(dir)
	for s in sources:
		fname, ext = os.path.splitext(s)
		if ext == ".x10":
			bench_file = s
			bench_name = fname
			break
	else:
		return
	color_printer.print_bold("[WORKING] compile %s..."%(bench_name))
	cmd = x10cpp_opt + [dir+bench_file, 
			"-o", "%s/%s.out"% (dir, bench_name)]
	execute(cmd, True)
	for opt in polyopt_options:
		color_printer.print_bold("[WORKING] compiling option %s using PolyOpt..."%(opt))
		target_path = dir + re.match("--polyopt-([a-zA-Z0-9\-_]+)", opt).group(1).replace("-", "_")
		if not os.path.exists(target_path):
			os.makedirs(target_path)
		#cmd = [polyopt_bin, 
				#"-rose:skipfinalCompileStep",
				#"-rose:o", 
				#"%s/%s.x10"%(target_path, bench_name), 
				#opt,
				#dir + "/" + bench_file]
		#execute(cmd, True)

		color_printer.print_bold("[WORKING] compiling using x10c++...")
		cmd = x10cpp_opt + ["%s/%s.x10"%(target_path, bench_name), 
				"-o", "%s/%s.out"% (target_path, bench_name)]
		out, err = execute(cmd, True)
		f = open(target_path + "/report.log", "wb")
		f.write(out + err)
		f.close()

def walk_pharse(dir, only_check=False):
	benchs = os.listdir(dir)
	for bench_dir in benchs:
		if not only_check:
			poly_opt_compile(dir + bench_dir + "/")
		check_output(dir + bench_dir + "/")

def check_output(dir):
	for opt in polyopt_options:
		target_path = dir + re.match("--polyopt-([a-zA-Z0-9\-_]+)", opt).group(1).replace("-", "_")
		color_printer.print_bold("checkling %s..."%(target_path))
		if os.path.exists(target_path):
			lst = os.listdir(target_path)
			if not glob.glob(target_path+ "/*.out"):
				color_printer.print_fail("%s compiled fail!"%(target_path))
		else:
			color_printer.print_fail("%s compiled fail!"%(target_path))

if __name__ == '__main__':
	only_check = False
	if len(sys.argv) > 1:
		if sys.argv[1] == "check" or (len(sys.argv) > 2 and sys.argv[2] == "check"):
			only_check = True
		if sys.argv[1] == "single":
			poly_opt_compile(sys.argv[2])
			exit()
	for dir in benchmark_directories:
		walk_pharse(dir, only_check)
