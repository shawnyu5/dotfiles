<!-- vim-markdown-toc GFM -->

* [nginx](#nginx)
* [system commands](#system-commands)
   * [shutdown](#shutdown)
   * [WiFi](#wifi)
* [Installing nodejs](#installing-nodejs)
* [tmux](#tmux)
   * [Copying](#copying)
* [Command line](#command-line)
   * [Zsh completion](#zsh-completion)
   * [Installing packages on command line](#installing-packages-on-command-line)
      * [To uninstall](#to-uninstall)
   * [current time and date](#current-time-and-date)
   * [bc calculator](#bc-calculator)
* [Postgres](#postgres)

<!-- vim-markdown-toc -->


# nginx

Config files are stored in `/var/www/html/`

It is deployed by default on port 80.

# system commands

## shutdown

`shutdown now`

Shuts down the computer right now.

By default, it waits 1 minute before shutting down

## WiFi

`nmtui` - WiFi manager GUI

# Installing nodejs

Download newest node JS from [website](https://nodejs.org/en/download/)

```bash
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf node-$VERSION-$DISTRO.tar.xz -C /usr/local/lib/nodejs 
```

Copy `nodejs/bin/node` binary to `/usr/local/bin`

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

# Postgres

To install postgres through apt:

```bash
sudo apt install postgresql
```

To connect to local postgres data base: 

```bash
sudo -u postgres psql
```

Upon first installing the database, the user must set it's local password:

1. Login to postures shell.

2. Set password

```
postgres=# \password
Enter new password:
Enter it again:
postgres=# \q
```

Done
