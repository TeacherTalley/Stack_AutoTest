#!/bin/bash
repo=Stack_AutoTest
echo "#################### START: AutoTest Setup ##################################"
echo " To be consistent with the grading environment, assume we are starting out "
echo " in the source directory (i.e., the parent of the AutoTest directory)."
echo " You will get a cd error if you execute directly from the AutoTest directory."
echo "#############################################################################"
cd $repo
echo
echo "#################### START: AutoTest Results #####################"
echo "--- Checking code format (cpplint) ---"
./AutoTest_Style.sh
echo
echo "--- Checking main output (diff) ---"
cd build
../AutoTest_OutputTest.sh
echo
echo "--- Unit testing (googletest - all tests at once) ---"
ctest
echo
echo "--- Unit testing (single test at a time) ---"
./AutoTest_gtests --gtest_filter=StackTest.Empty
./AutoTest_gtests --gtest_filter=StackTest.Size
./AutoTest_gtests --gtest_filter=StackTest.Top
./AutoTest_gtests --gtest_filter=StackTest.TopEmptyStack
./AutoTest_gtests --gtest_filter=StackTest.Push
./AutoTest_gtests --gtest_filter=StackTest.Pop
./AutoTest_gtests --gtest_filter=StackTest.PopEmptyStack
./AutoTest_gtests --gtest_filter=StackTest.ToString
./AutoTest_gtests --gtest_filter=StackTest.Print
./AutoTest_gtests --gtest_filter=StackTest.CopyConstructor

./AutoTest_gtests --gtest_filter=QueueTest.Empty
./AutoTest_gtests --gtest_filter=QueueTest.Size
./AutoTest_gtests --gtest_filter=QueueTest.Front
./AutoTest_gtests --gtest_filter=QueueTest.FrontEmptyQueue
./AutoTest_gtests --gtest_filter=QueueTest.Enqueue
./AutoTest_gtests --gtest_filter=QueueTest.Dequeue
./AutoTest_gtests --gtest_filter=QueueTest.DequeueEmptyQueue
./AutoTest_gtests --gtest_filter=QueueTest.ToString
./AutoTest_gtests --gtest_filter=QueueTest.Print
./AutoTest_gtests --gtest_filter=QueueTest.CopyConstructor

echo
cd ..
echo "#################### END: AutoTest Results   #####################"
echo
