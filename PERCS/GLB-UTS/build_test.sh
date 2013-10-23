#!/bin/bash
#SRC_PATH=/home/weiz/workspace/m3r/wglb/src
#x10c++ -g -O -NO_CHECKS -sourcepath $SRC_PATH  $SRC_PATH/uts/MyUTS.x10 -d myuts  

#x10c++ -g -O -NO_CHECKS ./uts/UTS.x10 -o ./uts_orig
#x10c++ -g -O -NO_CHECKS ./uts/UTSLocalJobRunner.x10 -o ./uts_wei
#x10c++ -define LOG -g -O -NO_CHECKS ./uts/UTSGlobalScheduler.x10 -o ./UTS_global
#x10c++ -g -O -NO_CHECKS ./uts/UTSGlobalScheduler.x10 -o ./UTS_global
#x10c++ -define LOG -g -O -NO_CHECKS ./uts/MyUTSGlobalRunner.x10 -o ./MyUTSGlobalRunner
#x10c++ -define LOG  -STATIC_CHECKS -g -O ./uts/MyUTSGlobalRunner.x10 -o ./MyUTSGlobalRunner

#x10c++ -define LOG -STATIC_CHECKS -g -O ./myuts/MyUTS.x10 -o ./MyUTS
x10c++ -g -O ./test/TestMyUTS.x10 -o ./myutstest
