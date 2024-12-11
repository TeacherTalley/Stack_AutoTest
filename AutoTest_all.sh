#!/bin/bash
#--------------------------------------------------------------------------
# File: AutoTest_all.sh
# Programmer: Michelle Talley
# Copyright 2024 Michelle Talley University of Central Arkansas
#--------------------------------------------------------------------------
repo=Stack_AutoTest
echo "#################### START: AutoTest Setup ##################################"
echo " To be consistent with the grading environment, assume we are starting out "
echo " in the source directory (i.e., the parent of the AutoTest directory)."
echo " You will get a cd error if you execute directly from the AutoTest directory."
echo "#############################################################################"
cd $repo
echo
echo "#################### START: AutoTest Results #####################"
./AutoTest_Style.sh $repo main.cpp Stack.h Queue.h
echo
cd build
../AutoTest_OutputTest.sh $repo/build
echo
echo "--- Unit testing (googletest - all tests at once) ---"
ctest
echo
# GitHub Classroom auto-grading runs the following commands from the current
# directory of the project being tested.  To similate that here, we need to
# change to the project directory before running the tests.
#
cd ../..
echo "--- Unit testing (single test at a time) ---"
# Note: The following commands should be exactly the same as specified in classroom.yml
./Stack_AutoTest/AutoTest_gtest.sh StackTest.Empty
./Stack_AutoTest/AutoTest_gtest.sh StackTest.Size
./Stack_AutoTest/AutoTest_gtest.sh StackTest.Top
./Stack_AutoTest/AutoTest_gtest.sh StackTest.TopEmptyStack
./Stack_AutoTest/AutoTest_gtest.sh StackTest.Push
./Stack_AutoTest/AutoTest_gtest.sh StackTest.Pop
./Stack_AutoTest/AutoTest_gtest.sh StackTest.PopEmptyStack
./Stack_AutoTest/AutoTest_gtest.sh StackTest.ToString
./Stack_AutoTest/AutoTest_gtest.sh StackTest.Print
./Stack_AutoTest/AutoTest_gtest.sh StackTest.CopyConstructor
./Stack_AutoTest/AutoTest_gtest.sh StackTest.SaveRestore

./Stack_AutoTest/AutoTest_gtest.sh QueueTest.Empty
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.Size
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.Front
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.FrontEmptyQueue
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.Enqueue
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.Dequeue
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.DequeueEmptyQueue
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.ToString
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.Print
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.CopyConstructor
./Stack_AutoTest/AutoTest_gtest.sh QueueTest.SaveRestore

echo
echo "#################### END: AutoTest Results   #####################"
echo
