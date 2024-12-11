#!/bin/bash
#--------------------------------------------------------------------------
# File: AutoTest_OutputTest.sh
# Programmer: Michelle Talley
# Copyright 2024 Michelle Talley University of Central Arkansas
#--------------------------------------------------------------------------
build_dir=$1
if [ -z "$build_dir" ]; then
  echo "Error: Build directory parameter is missing."
  exit 1
fi
cd $build_dir

# See: https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
red="\033[31m"
blue="\033[34m"
green="\033[32m"
reset="\033[0m"

printf "${green}[==========]${reset}\n"
printf "${green}[ RUN      ] 'main' in build directory ${build_dir}${reset}\n"
printf "${green}[----------]${reset}\n"

# Set the grade penalty for a failed test
# This is indepedent of the graded results and must be manually applied
failure_penalty="-50"

./main > test_main_output.txt 2>&1
main_rc=$?
if [ $main_rc -eq 139 ]; then
    # reason="(Segmentation Fault) - Grade Penalty: $failure_penalty points"
    reason="(Segmentation Fault) - Grade Penalty to be assessed."
elif [ $main_rc -eq 134 ]; then
    # reason="(Uncaught Exception) - Grade Penalty: $failure_penalty points"
    reason="(Uncaught Exception) - Grade Penalty to be assessed."
else
    # reason="(Exit code $main_rc) - Grade Penalty: $failure_penalty points"
    reason="(Exit code $main_rc) - Grade Penalty to be assessed.)"
fi

if [ $main_rc -ne 0 ]; then
  printf "${red}[==========]${reset}\n"
  printf "${red}[  FAILED  ] 'main' failed ${reason}${reset}\n"
  printf "${red}[==========]${reset}\n"
else
  printf "${green}[==========]${reset}\n"
  printf "${green}[  PASSED  ] 'main' executed successfully${reset}\n"
  printf "${green}[==========]${reset}\n"
fi

printf "${green}[==========]${reset}\n"
printf "${green}[ COMPARE  ] Check output -- Desired on left, Actual on right${reset}\n"
printf "${green}[----------]${reset}\n"

#diffopts="--ignore-blank-lines --side-by-side --ignore-space-change --suppress-common-lines --color=always"
diffopts="--ignore-blank-lines --side-by-side --ignore-space-change --color=always"
diff $diffopts ../AutoTest_main_output.txt test_main_output.txt
diff_rc=$?

if [ $diff_rc -ne 0 ]; then
  printf "${red}[==========]${reset}\n"
  printf "${red}[  FAILED  ] 'main' output does not match expected${reset}\n"
  printf "${red}[==========]${reset}\n"
else
  printf "${green}[==========]${reset}\n"
  printf "${green}[  PASSED  ] 'main' output matches expected${reset}\n"
  printf "${green}[==========]${reset}\n"
fi

if [ $main_rc -ne 0 ]; then
  exit $main_rc
fi
exit $diff_rc
