# Customizing vim highlighting colors

go to /usr/share/nvim/runtime/syntax/syncolor.vim to change syntax highlighting colors

# Using tabs

```vim:

:tabe

```

open all files in tabs
      maped to control shift A in vim

## Usage

open a bunch of files via command line

```vim
vim file1 file2 file3
```

then enter **:tabe** or control shift A to view all files in tabs
**gt** or **gT** to shift back and forth between tabs

# Auto complete

control n for word complete
control x + f for file name completion

# vim commands

## case switching

~ swaps the case of the letter the cursor is currently on

### capilization

gu changes letters to lowercase
gU changes letters to capital

## skip a block of code

{ skips a block of code going downwards. } skips upwards

## indenting

<< indents left. >> indents right

## auto indent

=i{ to autoindent a block of code, when the indentation is inconstant

# setting markers

go to a line you would like to set a marker on.
press `m<mark letter>`

`'<marker letter>` to jump to the marker

## folding

requires setting a marker first.
go to the end of the block that needs folding
type `zf'<marker name>` to fold that section
`zo` to unfold the block (**o**pen)
`zc` to close the block (**c**lose)

# run vim commands from command line

to open vim and run a vim command at the same time (ie in a script). Run `vim
+:<vim command> <file name>`

# format text

`gq` followed by a text object, q for the whole paragraph reformates text so
there is one text line per vim line

**notes:** gq has been maped to q in normal mode

## opening another file in vim

`gf` opens the highlighted file in the current file another vim buffer. `^` to
go back to previous file

## reslecting text

`gv` reselect the text you just selected

## run the last subsutite command globally

if you are in need to run a substute command. You could first run the command
on the current line. ie `:s/abc/def/g`. and if that command is successful. You
could run g& to run the last substution command globally.

# markDown preview

`:MarkdownPreview`

opens the current markdown doc in a chrome window and
recompiles every time the document is saved

# diff mode

`vim -d <file1> <file2>`

will open the 2 files in a split and compare the
differences

## when files are already open

lets say you have a file open already. And you want to
compare it against another file that is not open.

you can open the other file by doing `:vs <other file
name>` to open the other file in a verticle split.

then do `:windo diffthis` to apply "diff mode" to all open
windows

## disable diff mode

`:diffoff` and keep all files in split window

# running vim commands while opening vim

`vim "+ normal Gzz" <file name>`

will open vim, and excute in normal mode G, then zz.

# pip standard input into vim

`<terminal command> | vim -`

will open the output of the previous command in a vim
buffer

# bring outputs of terminal commands into vim within vim it self

Within vim, we know `:! <shell command>` excutes a shell command

But if we want to bring the output of the shell command into vim, we can do `:.! <shell command>`
