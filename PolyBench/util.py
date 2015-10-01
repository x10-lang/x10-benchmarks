import re, os

def file_as_lines(file_name):
	f = open(file_name, "rb")
	s = f.readlines()
	f.close()
	return s

def delete_line_any(fun, lines):
	for (i, line) in enumerate(lines):
		if fun(line):
			lines[i] = False
	return filter(lambda l: l, lines)

def delete_line_startswith(s, lines):
	fun = lambda l : l.startswith(s)
	return delete_line_any(fun, lines)

def delete_line_include(s, lines):
	fun = lambda l : s in l
	return delete_line_any(fun, lines)

def find_and_replace(search, replace, lines, start=0):
	for i in range(start, len(lines)):
		line = lines[i]
		if search in line:
			lines[i] = line.replace(search, replace)
	return lines

def find_and_replace_re(ptn, fun, lines, dotall=False):
	for (i, line) in enumerate(lines):
		if dotall:
			res = re.sub(ptn, fun, line, re.DOTALL)
		else:
			res = re.sub(ptn, fun, line)
		if res:
			lines[i] = res
	return lines

def add_indent(lines, width = 2):
	for (i, line) in enumerate(lines):
		lines[i] = " "*width + line
	return lines

def lines_to_file(filename, lines):
	s = "".join(lines)
	if not os.path.exists(os.path.dirname(filename)) and os.path.dirname(filename):
		os.makedirs(os.path.dirname(filename))
	f = open(filename, "wb")
	f.write(s)
	f.close()

def split_and_trim(s, sep):
	return [x.strip() for x in s.split(sep)]

def replace_span(s, span, replace):
	return s[:span[0]] + replace + s[span[1]:]
