import os, sys, subprocess, re, glob, signal
import color_printer
import util

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
		# too slow in x10
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

def add_his(prs,title,data):
	slide = prs.slides.add_slide(prs.slide_layouts[5])
	slide.shapes.title.text = title

	# define chart data ---------------------
	#base = data[0]
	#data = [e / base for e in data]
	chart_data = ChartData()
	chart_data.categories = ['base', 'ft', 'po', 'pt']
	chart_data.add_series('C', (data[0],data[2],data[4],data[6]))
	chart_data.add_series('X10', (data[1],data[3],data[5],data[7]))
	#chart_data = ChartData()
	#chart_data.categories = ['East', 'West', 'Midwest']
	#chart_data.add_series('Series 1', (19.2, 21.4, 16.7))

	# add chart to slide --------------------
	x, y, cx, cy = Inches(1), Inches(2), Inches(8), Inches(4.5)
	graphic_frame =slide.shapes.add_chart(
		XL_CHART_TYPE.COLUMN_CLUSTERED, x, y, cx, cy, chart_data
	)

	chart = graphic_frame.chart
	chart.has_legend = True
	chart.legend.position = XL_LEGEND_POSITION.RIGHT
	chart.legend.include_in_layout = False

polybench_c_path = "../polybench-c-large-time/"

def catch_a_data(dir):
	try:
		lines = util.file_as_lines(dir + "/time.dat")
	except IOError:
		return 0
	res = []
	for l in lines:
		try:
			res.append(float(l))
		except ValueError:
			continue
	return sum(res) / len(lines)

def signal_handler(signal, frame):
	color_printer.print_warning("Terminated by User. The measure isn't completed!")
	sys.exit(0)

def gen_a_graph(dir):
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
	global prs
	res = []
	# run c standard version:
	res.append(catch_a_data(polybench_c_path + dir))
	# run x10 standard version:
	res.append(catch_a_data(dir))
	for opt in polyopt_options:
		#color_printer.print_bold("[WORKING] running subversion compiled using %s..."%(opt))
		target_path = dir + re.match("--polyopt-([a-zA-Z0-9\-_]+)", opt).group(1).replace("-", "_")
		# run c version firstly
		res.append(catch_a_data(polybench_c_path + target_path))
		# run x10 
		res.append(catch_a_data(target_path))
	#add_his(prs, bench_name, res)
	print bench_name + "," + ",".join([str(e) for e in res])

if __name__ == '__main__':
	signal.signal(signal.SIGINT, signal_handler)

	if len(sys.argv) > 1:
		gen_a_graph(sys.argv[1])
		exit()
	else:
		for dir in benchmarks:
			gen_a_graph(dir)
