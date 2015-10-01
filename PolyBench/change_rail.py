import os, sys, subprocess, re, glob, signal
import color_printer, util

c_expression = '[a-zA-Z0-9_\+\-\*\.\/ ]+'

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

def replace_rail(filename):
	lines = util.file_as_lines(filename)
	if any(["import x10.array.Array_2;" in l for l in lines]):
		color_printer.print_warning("already replaced Rail in %s, skip..."%(filename))
		return
	else:
		lines = ["import x10.array.Array_2;\n",
				"import x10.array.Array_3;\n"] + lines
		lines = util.find_and_replace(')(', ',', lines)
	i = 0
	balance = -1
	arg_lst = []
	allocate_index = 0
	while i < len(lines):
		l = lines[i]
		m = re.search('new Rail\[Rail\[Rail\[('+c_expression+')\]\]\]\(('+c_expression+')\)', l)
		if m:
			allocate_index = i
			while True:
				i += 1
				m2 = re.search('new Rail\[Rail\[('+c_expression+')\]\]\(('+c_expression+')\)', lines[i]) 
				if m2 and m2.group(1) == m.group(1):
					arg_lst.append(m2.group(2))
				m2 = re.search('new Rail\[('+c_expression+')\]\(('+c_expression+')\)', lines[i]) 
				if m2 and m2.group(1) == m.group(1):
					arg_lst.append(m2.group(2))
				if "{" in lines[i]:
					balance = balance + 1 if not balance == -1 else 1
				if "}" in lines[i]:
					balance -= 1
				if balance == 0:
					break
			lines[allocate_index] = util.replace_span(l, m.span(),
					'new Array_3[' + m.group(1) + '](' + m.group(2) + "".join([","+arg for arg in arg_lst]) + ")")
			arg_lst = []
			balance = -1
			lines = lines[:allocate_index+1]+lines[i+1:]
			i = allocate_index
		m = re.search('new Rail\[Rail\[('+c_expression+')\]\]\(('+c_expression+')\)', l) 
		if m:
			allocate_index = i
			while True:
				i += 1
				m2 = re.search('new Rail\[('+c_expression+')\]\(('+c_expression+')\)', lines[i]) 
				if m2 and m2.group(1) == m.group(1):
					arg_lst = [m2.group(2)]
				if "{" in lines[i]:
					balance = balance + 1 if not balance == -1 else 1
				if "}" in lines[i]:
					balance -= 1
				if balance == 0:
					break
			lines[allocate_index] = util.replace_span(l, m.span(),
					"new Array_2[%s](%s,%s)"%(m.group(1), m.group(2), arg_lst[0]))
			arg_lst = []
			balance = -1
			lines = lines[:allocate_index+1]+lines[i+1:]
			i = allocate_index
		i += 1
	lines = util.find_and_replace_re('Rail\[Rail\[Rail\[('+c_expression+')\]\]\]', lambda m: "Array_3["+m.group(1)+"]", lines)
	lines = util.find_and_replace_re('Rail\[Rail\[('+c_expression+')\]\]', lambda m: "Array_2["+m.group(1)+"]", lines)
	util.lines_to_file(filename, lines)

def replace_file(dir):
	sources = os.listdir(dir)
	for s in sources:
		fname, ext = os.path.splitext(s)
		if ext == ".x10":
			bench_file = s
			bench_name = fname
			break
	else:
		return
	color_printer.print_bold("[WORKING] replacing %s..."%(bench_name))
	#replace_rail(dir+bench_file)
	for opt in polyopt_options:
		color_printer.print_bold("[WORKING] replacing option %s using PolyOpt..."%(opt))
		target_path = dir + re.match("--polyopt-([a-zA-Z0-9\-_]+)", opt).group(1).replace("-", "_")
		replace_rail(target_path+"/"+bench_file)

def walk_pharse(dir):
	benchs = os.listdir(dir)
	for bench_dir in benchs:
		replace_file(dir + bench_dir + "/")

def signal_handler(signal, frame):
	print "Aborted"
	sys.exit(0)

if __name__ == '__main__':
	signal.signal(signal.SIGINT, signal_handler)
	color_printer.print_warning('WARNING! This operation cannot be reverted! Please make sure you have a backup.')
	color_printer.print_bold('Press any key to continue, or Ctrl-v to escape.')
	dummy = raw_input()
	if len(sys.argv) > 1:
		if sys.argv[1] == "single":
			replace_rail(sys.argv[2])
			exit()
		else:
			walk_pharse(sys.argv[1])
	else:
		for dir in benchmark_directories:
			walk_pharse(dir)
