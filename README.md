# Stack_AutoTest
Stack Auto Testing Suite

This repository contains the auto test suite for the **Stack** lab assignment using the GitHub Classroom autograding capabilities.

The strategy is to clone this repository into the student's submitted repository each time the student commits their code.

To prevent overrides of the code by students, the **Stack** repository should have a **.gitignore** file that includes the pattern "*AutoTest*", but the **.gitignore** file for this repository (**Stack_AutoTest**) should **not** contain that pattern.

To configure autograding, edit `.github/classroom/autograding.json` in the **Stack** repository (**not** the **Stack_AutoTest** repository). This file defines the tests to run and the points for each test.  The first step in this file performs the clone of the **Stack_AutoTest** into the test environment.  As such, the first step should have `"points": 0` in the definition.  The remaining steps execute the actual tests.

**Make sure to create `AutoTest_main_output.txt` by executing the solution `main`.**  
