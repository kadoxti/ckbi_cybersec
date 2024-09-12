# Binary analysys

To start, we can use the `strings` command to see if there are any binaries or shared libraries being loaded during execution.

`strace` monitors the system calls and signals of a specific program and provides the execution sequence from start to finish. It is helpful when you do not have the source code and would like to debug the execution of a program.
