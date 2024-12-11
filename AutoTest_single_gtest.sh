#!/bin/bash
#--------------------------------------------------------------------------
# File: AutoTest_single_gtest.sh
# Programmer: Michelle Talley
# Copyright 2024 Michelle Talley University of Central Arkansas
#--------------------------------------------------------------------------
# GTest does not report segmentation faults as errors when running a single test.
# This script runs the individual tests and reports an error for any test
# with a non-zero exit code.
#
# See here for good information on formatted output:
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
$1 $2
rc=$?
if [ $rc -eq 139 ]; then
  reason="(Segmentation Fault)"
else
  reason="(Failed with exit code $rc)"
fi

testname=$(echo $2 | awk -F'=' '{print $2}')

if [ $rc -ne 0 ]; then
  red="\033[31m"
  reset="\033[0m"
  printf "${red}[==========]${reset}\n"
  printf "${red}[  FAILED  ] ${testname} ${reason}${reset}\n"
  printf "${red}[==========]${reset}\n" 
fi

exit $rc