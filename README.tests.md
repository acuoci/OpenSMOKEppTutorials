# OpenSMOKE++ Test
This page describes how to run and create new tests for OpenSMOKE++. The main idea is that this repository, which collects a number of tutorials that can be used to learn how to setup OpenSMOKE++ simulations, can also be used to test the modifications to the OpenSMOKE++ source code.

## Requirements
The testing system is based on [numdiff](https://www.nongnu.org/numdiff/), which is an advanced version of the linux command line tool *diff*, which allows comparison between two files ignoring small numeric differences and different numeric formats.

## How to run a test
To run the whole test suite it's sufficient to execute the bash file *Alltest.sh*:
```
chmod +x Alltest.sh
./Alltest.sh
```
The testing system will loop through all the solver tutorials (i.e. BatchReactor, PlugFlowReactor, ecc) and it will prompt the folder of the simulation and the result of the test with a clear `[PASS]` or `[FAIL]` indication. If a test fails, you can easily verify what's wrong inspecting the file `log.diff`, created in the folder of the failed test.

If you want to run a single set of tests, for example just the batch reactors, you can specify the name of the solver that you want to test:
```
./Alltest.sh OpenSMOKEpp_BatchReactor.sh
```
considering that the bash script accepts multiple input solvers.
When you are done with testing, you can clean all the output folders and files using the bash script `Allclean.sh`:
```
./Allclean.sh
```

## How to create a new test
Not all the simulations in this repository are included in the current version of the testing system. To add a new test you have to enter in a simulation folder, for example:
```
cd examples/OpenSMOKEpp_BatchReactor/01a-isothermal-constantvolume
```
and perform the simulation using the corresponding solver:
```
OpenSMOKEpp_BatchReactor.sh
```
the simulation results will be saved in the `Output` folder. Among the files which are in this folder, one (or more) of them must be selected for being the current reference solution of the test case. This file must be saved as `target`. For example, if the file `Output/Output.out` is selected as target, it will be copied as follows:
```
cp Output/Output.out target
```

At this point you have the target file, and you just need to add a file called `Test.sh` which contains the instructions to perform a test. Indeed, when the bash script `Alltest.sh` is called, it loops over all the example subfolders and, when the file `Test.sh` is found, it run a simulation and performs a comparison with the target file. If such file is not present, the test case is skipped and not considered among the tests. A simple `Test.sh` file contains the following lines:
```
cd $(dirname "$0")

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_BatchReactor.sh

runDifference Output/Output.out
``` 
where the first three lines adjust the path of the simulation, include the functions defined in `etc/testFunctions.sh`, and clean the test case from previous results. The function `runApplication` takes a solver as argument, which is the solver that must be used for this simulation, and perform the simulation creating a new `Output` folder. At this point `runDifference` takes the new results in `Output/Output.out` and compare them with the target file.

At this point, a new test case was created and the bash script `Alltest.sh` will automatically add it to the list of test to perform. However, there are situations in which the basic `Test.sh` file explained above is not sufficient. The two files are compared using *numdiff* imposing a default relative tolerance between the number of the two files. If the numbers in `Output/Output.out` and those in `target` differ with a higher relative constant the test fails. Using this approach, instead of a simple difference of characters in those two files, we avoid small numerical differences depending on the operative system and the hardware were the simulation runs to fail the test. The next paragraph explain how to refine the basic `Test.sh` explained above.

### Filter values
The comparison between the target file and the new results is based on a relative error, which is defined as:
```math
\varepsilon = \dfrac{|v_{target}-v_{new}|}{v_{target}}
```
this implies that, if $v_{target}$ is null, while $v_{new}$ is not, due for example to a small approximation error, the calculation of the relative error will lead to a division by zero which will cause the test to fail. Therefore, the idea to overcome this problem is to filter out *spurious values* from the new output file. This is perfomed using the function `filterValues`:
```
filterValues Output/Output.out > Output/Output.filtered
```
which removes all the values lower than $1\times 10^{-12}$ (the default tolerance can be easily specified by the user), creating a new file called `Output/Output.filtered`. This file can be compared by the `runDifference` function, simply by replacing the input file name when the function is used.

### Specify the relative tolerance
At this point it should be clear that the core of the tests are the `Test.sh` files, which implements the rules to run the simulation, and to compare the output file that we want with a specific target. The difference is based on the relative tolerance which, by default, is equal to $1\times 10^{-3}. If a different tolerance need to be set for a specific test case, it can be specified as:
```
runDifference Output_to_compare --relative-tolerance 1.e-4
```
The same approach can be used to specify other options for *numdiff*, which are documented [here](https://www.nongnu.org/numdiff/numdiff.html).

### Select specific columns to compare
If you don't want to compare the whole `Output/Output.out` file with the target, you can select only a column using the following function:
```
getColumn 2 Output/Output.out > Output/Output.filtered
```
Which extract the second column from the file `Output/Output.out` and saves that column in the file `Output/Output.filtered`. This last file can be used by the `runDifference` function. Pay attention to create the target file accordingly: if you use just a single column of the output file, then the target file should be created just with that column.

### Ignore a number of rows
In some cases, you may want to compare the `stdout` from the OpenSMOKE++ simulation. However, OpenSMOKE++ writes on the `stdout` information which are specific to the machine where the simulation runs (for example, it prints the time required by the simulations, which is an information that changes at every run). Let's suppose that those information are in the first 35 lines of the output file. Therefore, we can cut off those lines using the command:
```
awk 'NR>35' Output/ROPA.out > log.ROPA
```
which removes the first 35 lines from the file `Output/ROPA.out` creating a new file called `log.ROPA` which can be used by the `runDifference` function.

Therefore, the tools for improving the output and target files are provided. Using these functions we can improve the performance of the testing system by specifying what we want to compare for every specific test, and using which tolerances.
