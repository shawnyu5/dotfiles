# system commands

## shutdown

`shutdown now`

shuts down the computer right now.
by default, it waites 1 minute before shutting down

# bash

## current time and date

`date` gets the current time and date

`date +"%T"` gets the current time in 24 hour clock

## bc calculator

We can either echo commands into it: `echo "3<4" | bc -l`

Or we can pipe it in: `bc -l <<< "3<4"`

Unlike bash, it returns **1** for *true*, and **0** for *false*.

## Bash debug mode
