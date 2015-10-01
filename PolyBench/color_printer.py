HEADER = '\033[95m'
OKBLUE = '\033[94m'
OKGREEN = '\033[92m'
WARNING = '\033[93m'
FAIL = '\033[91m'
ENDC = '\033[0m'
BOLD = '\033[1m'
UNDERLINE = '\033[4m'

def print_ok_green(s):
	print OKGREEN + s + ENDC

def print_warning(s):
	print WARNING + s + ENDC

def print_bold(s):
	print BOLD + s + ENDC

def print_fail(s):
	print FAIL + s + ENDC
