#!/bin/bash
echo Testing: $1
./LinkedList_AutoTest/build/AutoTest_gtests --gtest_filter=$1
