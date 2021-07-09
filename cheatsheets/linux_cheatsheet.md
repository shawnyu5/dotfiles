<!-- vim-markdown-toc GFM -->

* [system commands](#system-commands)
    * [shutdown](#shutdown)
* [bash](#bash)
    * [Installing packages on command line](#installing-packages-on-command-line)
        * [To uninstall](#to-uninstall)
    * [current time and date](#current-time-and-date)
    * [bc calculator](#bc-calculator)
    * [Bash debug mode](#bash-debug-mode)

<!-- vim-markdown-toc -->


# system commands

## shutdown

`shutdown now`

Shuts down the computer right now.

By default, it waits 1 minute before shutting down

# bash

## Installing packages on command line

When using i3, it does not vibe well with gnome keyring. So we need to install
packages on the command line instead of using the GUI. Most packages end with
`.deb` extension. 

### To uninstall 

To uninstall a package from `dpkg`, run `dpkg -r <package name>` to uninstall
that package.

Run the command `sudo dpkg -i <package name>` to install the package.

## current time and date

`date` gets the current time and date

`date +"%T"` gets the current time in 24 hour clock

## bc calculator

We can either echo commands into it: `echo "3<4" | bc -l`

Or we can pipe it in: `bc -l <<< "3<4"`

Unlike bash, it returns **1** for *true*, and **0** for *false*.

## Bash debug mode
