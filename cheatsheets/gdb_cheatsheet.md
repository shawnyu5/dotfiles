<!-- vim-markdown-toc GFM -->

    * [setting breakpoints](#setting-breakpoints)
    * [Start](#start)
    * [Run](#run)
    * [Step](#step)
    * [Next](#next)
    * [Backtrack](#backtrack)
    * [Print](#print)
    * [Watch](#watch)
    * [List](#list)
    * [Finish](#finish)
    * [Until](#until)
    * [Continue](#continue)
    * [Refresh](#refresh)
* [Valgrind intergration](#valgrind-intergration)

<!-- vim-markdown-toc -->

`g++ -g <files>`

Use -g flag to produce meaningful output debug information

`gdb <excutable>`

Run the executable through through gdb

`layout next` to be able to see our code

## setting breakpoints

`b 43`

Sets a breakpoint at line 43

## Start

Sets a temporary breakpoint at main and stops there

## Run

`run`

Executes the program.

If command line arguments are needed to be passed in, append after run

## Step

`step`

Step into a function call. Can be abbreviated to *s*

## Next

`next`

Step over the function. Can be abbreviated to *b*

## Backtrack

`bt`

Back trace shows the program execution

## Print

`print <variable>`

Prints the value of the variable

## Watch

`watch <variable>` will display the old and new value of a variable as it
changes

## List

`list`

Shows some of the current code. Can be abbreviated to **l**.

## Finish

Jumps until the end of a function.

## Until

Jumps to the end of the loop

## Continue 

Continue execution until the next time the break point is hit

Can be shortened to **c**

## Refresh

Refreshes the layout screen

# Valgrind intergration

GDB can also be integrated with valgrind for better memory leak debugging

1. To start valgrind with GDB, run

```bash
valgrind --vgdb=yes --vgdb-error=0 <program> <arguments>
```

The `vgdb-error` tells GDB how many errors it should detect before stooping the
program. For instance, 1 would mean as soon as valgrind detects a memory leak,
it would pass control to GDB, as if a break point has been hit.

2. In a separate window, start another instance of GDB, and run

```bash
gdb

target remote | vgdb
```

Basically what running the command in step one tells us to do, or the above
should be enough.

At any point, you can tell valgrind to check for memory issues by running:

```bash
monitor leak_check
```
