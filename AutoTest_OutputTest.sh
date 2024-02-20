#!/bin/bash
cd Stack_AutoTest/build
./main > test_main_output.txt 
diffopts="--ignore-blank-lines --side-by-side --ignore-space-change --suppress-common-lines --color=always"
diff $diffopts ../AutoTest_main_output.txt test_main_output.txt