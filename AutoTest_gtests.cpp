/**
* ---------------------------------------------------------------------
* @copyright
* Copyright 2024 Michelle Talley University of Central Arkansas
*
* @author: Michelle Talley
* @course: Data Structures (CSCI 2320)
*
* @file AutoTest_gtests.cpp
* @brief Google Test for Stack lab.
-----------------------------------------------------------------------
*/

#include <iostream>
#include <string>

#include <gtest/gtest.h>

#include "Stack.h"
#include "Queue.h"

// String trim functions - std::str does not have a built-in trim function
// see: https://stackoverflow.com/questions/216823/how-to-trim-a-stdstring
// trim from start (in place)
inline void ltrim(std::string &s)
{
    s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](unsigned char ch)
                                    { return !std::isspace(ch); }));
}

// trim from end (in place)
inline void rtrim(std::string &s)
{
    s.erase(std::find_if(s.rbegin(), s.rend(), [](unsigned char ch)
                         { return !std::isspace(ch); })
                .base(),
            s.end());
}

// trim from both ends (in place)
inline void trim(std::string &s)
{
    rtrim(s);
    ltrim(s);
}

// trim from start (copying)
inline std::string ltrim_copy(std::string s)
{
    ltrim(s);
    return s;
}

// trim from end (copying)
inline std::string rtrim_copy(std::string s)
{
    rtrim(s);
    return s;
}

// trim from both ends (copying)
inline std::string trim_copy(std::string s)
{
    trim(s);
    return s;
}

// Stack tests

TEST(StackTest, Empty)
{
    Stack<int> s;
    EXPECT_TRUE(s.empty());
    s.push(1);
    EXPECT_FALSE(s.empty());
    s.pop();
    EXPECT_TRUE(s.empty());
}

TEST(StackTest, Size)
{
    Stack<int> s;
    EXPECT_EQ(s.size(), 0);
    s.push(1);
    EXPECT_EQ(s.size(), 1);
    s.push(2);
    EXPECT_EQ(s.size(), 2);
    s.pop();
    EXPECT_EQ(s.size(), 1);
}

TEST(StackTest, Top)
{
    Stack<int> s;
    s.push(1);
    EXPECT_EQ(s.top(), 1);
    s.push(2);
    EXPECT_EQ(s.top(), 2);
    s.pop();
    EXPECT_EQ(s.top(), 1);
}

TEST(StackTest, TopEmptyStack)
{
    Stack<int> s;
    EXPECT_THROW(s.top(), std::out_of_range);
}

TEST(StackTest, Push)
{
    Stack<int> s;
    s.push(1);
    s.push(2);
    EXPECT_EQ(s.top(), 2);
    s.pop();
    EXPECT_EQ(s.top(), 1);
    s.pop();
    EXPECT_TRUE(s.empty());
}

TEST(StackTest, Pop)
{
    Stack<int> s;
    s.push(1);
    s.push(2);
    EXPECT_EQ(s.top(), 2);
    s.pop();
    EXPECT_EQ(s.top(), 1);
    s.pop();
    EXPECT_TRUE(s.empty());
}

TEST(StackTest, PopEmptyStack)
{
    Stack<int> s;
    EXPECT_THROW(s.pop(), std::out_of_range);
}

TEST(StackTest, ToString)
{
    Stack<int> s;
    EXPECT_EQ(s.toString(), "");
    s.push(1);
    EXPECT_EQ(trim_copy(s.toString()), "1");
    s.push(2);
    EXPECT_EQ(trim_copy(s.toString()), "2 1");
    s.push(3);
    EXPECT_EQ(trim_copy(s.toString()), "3 2 1");
    s.pop();
    s.pop();
    EXPECT_EQ(trim_copy(s.toString()), "1");
}

TEST(StackTest, Print)
{
    Stack<int> s;
    EXPECT_NO_THROW(s.print());
    s.push(1);
    EXPECT_NO_THROW(s.print());
    // capture std::cout output
    s.push(2);
    s.push(3);
    testing::internal::CaptureStdout();
    s.print();
    std::string output = testing::internal::GetCapturedStdout();
    // EXPECT_EQ(output, "3 2 1\n");
    EXPECT_EQ(trim_copy(output), "3 2 1");
} 

TEST(StackTest, CopyConstructor)
{
    Stack<int> s1;
    s1.push(1);
    s1.push(2);
    Stack<int> s2(s1);
    EXPECT_EQ(s2.size(), s1.size());
    while (!s1.empty())
    {
        EXPECT_EQ(s1.top(), s2.top());
        s1.pop();
        s2.pop();
    }
}


// Queue tests

TEST(QueueTest, Empty)
{
    Queue<int> q;
    EXPECT_TRUE(q.empty());
    q.enqueue(1);
    EXPECT_FALSE(q.empty());
    q.dequeue();
    EXPECT_TRUE(q.empty());
}

TEST(QueueTest, Size)
{
    Queue<int> q;
    EXPECT_EQ(q.size(), 0);
    q.enqueue(1);
    EXPECT_EQ(q.size(), 1);
    q.enqueue(2);
    EXPECT_EQ(q.size(), 2);
    q.dequeue();
    EXPECT_EQ(q.size(), 1);
}

TEST(QueueTest, Front)
{
    Queue<int> q;
    q.enqueue(1);
    EXPECT_EQ(q.front(), 1);
    q.enqueue(2);
    EXPECT_EQ(q.front(), 1);
}

TEST(QueueTest, FrontEmptyQueue)
{
    Queue<int> q;
    EXPECT_THROW(q.front(), std::out_of_range);
}

TEST(QueueTest, Enqueue)
{
    Queue<int> q;
    q.enqueue(1);
    EXPECT_EQ(q.front(), 1);
    q.enqueue(2);
    EXPECT_EQ(q.front(), 1);
    EXPECT_EQ(q.size(), 2);
}

TEST(QueueTest, Dequeue)
{
    Queue<int> q;
    q.enqueue(1);
    q.dequeue();
    EXPECT_TRUE(q.empty());
    q.enqueue(1);
    q.enqueue(2);
    EXPECT_EQ(q.front(), 1);
    q.dequeue();
    EXPECT_EQ(q.front(), 2);
    q.dequeue();
    EXPECT_TRUE(q.empty());
}

TEST(QueueTest, DequeueEmptyQueue)
{
    Queue<int> q;
    q.enqueue(1);
    q.enqueue(2);
    q.dequeue();
    q.dequeue();
    EXPECT_THROW(q.dequeue(), std::out_of_range);
}

TEST(QueueTest, ToString)
{
    Queue<int> q;
    q.enqueue(1);
    q.enqueue(2);
    EXPECT_EQ(trim_copy(q.toString()), "1 2");
    q.enqueue(3);
    EXPECT_EQ(trim_copy(q.toString()), "1 2 3");
}

TEST(QueueTest, Print)
{
    Queue<int> q;
    EXPECT_NO_THROW(q.print());
    q.enqueue(1);
    q.enqueue(2);
    q.enqueue(3);
    // capture std::cout output
    testing::internal::CaptureStdout();
    q.print();
    std::string output = testing::internal::GetCapturedStdout();
    // EXPECT_EQ(output, "1 2 3\n");
    EXPECT_EQ(trim_copy(output), "1 2 3");
}

TEST(QueueTest, CopyConstructor)
{
    Queue<int> queue1;
    queue1.enqueue(1);
    queue1.enqueue(2);
    Queue<int> queue2(queue1);
    EXPECT_EQ(queue2.front(), 1);
    queue2.dequeue();
    EXPECT_EQ(queue2.front(), 2);
}

