<!-- vim-markdown-toc GFM -->

* [setting breakpoints](#setting-breakpoints)
* [Run](#run)
* [Step](#step)
* [Next](#next)
* [Backtrack](#backtrack)
* [Print](#print)
* [Watch](#watch)
* [List](#list)
* [Until](#until)

<!-- vim-markdown-toc -->

`g++ -g <files>`

Use -g flag to produce meaningful output debug information

`gdb <excutable>`

Run the executable through through gdb

`layout next` to be able to see our code

# setting breakpoints

`b 43`

Sets a breakpoint at line 43

# Run

`run`

Executes the program.

If command line arguments are needed to be passed in, append after run

# Step

`step`

Step into a function call. Can be abbreviated to *s*

# Next

`next`

Step over the function. Can be abbreviated to *b*

# Backtrack

`bt`

Back trace shows the program execution

# Print

`print <variable>`

Prints the value of the variable

# Watch

`watch <variable>` will display the old and new value of a variable as it
changes

# List

`list`

Shows some of the current code. Can be abbreviated to **l**.

# Until

Jumps to the end of the loop
