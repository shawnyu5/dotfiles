<!-- vim-markdown-toc GFM -->

* [system commands](#system-commands)
    * [shutdown](#shutdown)
    * [WiFi](#wifi)
* [tmux](#tmux)
    * [Copying](#copying)
* [Command line](#command-line)
    * [Zsh completion](#zsh-completion)
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

## WiFi

`nmtui` - WiFi manager GUI

# tmux

## Copying

1. `<prefix>[` to go into visual selection mode

2. make the selection

3. `<Enter>` to copy to system clip board

4. `<prefix>]` to paste

# Command line

## Zsh completion

[Zsh completion over
view](https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org#getting-started)

[Zsh completion helper function
manual](https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Completion-Functions)

Zsh completion script examples contained in
`/usr/share/zsh/functions/Completion/Unix`

## Installing packages on command line

When using i3, it does not vibe well with gnome keyring. So we need to install
packages on the command line instead of using the GUI. Most packages end with
`.deb` extension. 

Run the command `sudo dpkg -i <package name>` to install the package.

### To uninstall 

To uninstall a package from `dpkg`, run `dpkg -r <package name>` to uninstall
that package.

## current time and date

`date` gets the current time and date

`date +"%T"` gets the current time in 24 hour clock

## bc calculator

We can either echo commands into it: `echo "3<4" | bc -l`

Or we can pipe it in: `bc -l <<< "3<4"`

Unlike bash, it returns **1** for *true*, and **0** for *false*.

## Bash debug mode
