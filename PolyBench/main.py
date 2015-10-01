from converter import X10Converter
import sys, os

# USAGE: pass the benchmark directory which includes sub-directory of 
# each benchmark, such as 2mm/2mm.c, mvt/mvt.c...
# the script will convert all benchmark programs and generate the result
# in current directory with the same directory names.
# After that, you may want to use compile.py to compile all generate x10 code.
if __name__ == '__main__':
	filepath = sys.argv[1]
	dirs = [x[0] for x in os.walk(filepath)]
	names = [s.split("/")[-1] for s in dirs]
	#print dirs
	#print names
	for i in range(1,len(names)):
		c = X10Converter(dirs[i]+'/'+names[i]+".c", "stencils/" + names[i]+'/')
		c.process()

