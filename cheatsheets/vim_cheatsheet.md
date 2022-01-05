<!-- vim-markdown-toc GFM -->

* [Folds](#folds)
* [Window management](#window-management)
* [Spell check](#spell-check)
* [FZF plugin](#fzf-plugin)
* [Customizing vim highlighting colors](#customizing-vim-highlighting-colors)
* [Using tabs](#using-tabs)
   * [Usage](#usage)
* [Auto complete](#auto-complete)
* [vim commands](#vim-commands)
   * [case switching](#case-switching)
      * [capitalization](#capitalization)
   * [skip a block of Code](#skip-a-block-of-code)
   * [indenting](#indenting)
   * [auto indent](#auto-indent)
   * [detect file type](#detect-file-type)
   * [Screen navigations](#screen-navigations)
* [setting markers](#setting-markers)
   * [folding](#folding)
* [run vim commands from command line](#run-vim-commands-from-command-line)
* [format text](#format-text)
   * [opening another file in vim](#opening-another-file-in-vim)
   * [reslecting text](#reslecting-text)
   * [run the last subsutite command globally](#run-the-last-subsutite-command-globally)
* [markDown preview](#markdown-preview)
* [diff mode](#diff-mode)
   * [when files are already open](#when-files-are-already-open)
   * [disable diff mode](#disable-diff-mode)
* [running vim commands while opening vim](#running-vim-commands-while-opening-vim)
* [pip standard input into vim](#pip-standard-input-into-vim)
* [bring outputs of terminal commands into vim within vim it self](#bring-outputs-of-terminal-commands-into-vim-within-vim-it-self)
* [Sessions](#sessions)
   * [Creating sessions](#creating-sessions)
   * [Opening sessions](#opening-sessions)
* [Formatters](#formatters)
   * [clang-format](#clang-format)

<!-- vim-markdown-toc -->

# Folds

`zf#j` creates a fold from the cursor down `#` lines.

`zo` open a fold

`zO` opens all folds at the cursor.

`zc` closes a fold

`zd` deletes the fold at the cursor.

`zj` moves the cursor to the next fold.

`zk` moves the cursor to the previous fold.

`zm` increases the fold level by one.

`zM` closes all open folds.

`zr` decreases the fold level by one.

`zR` decreases the fold level to zero — all folds will be open.

`zE` deletes all folds.

`[z` move to start of open fold.

`]z` move to end of open fold.

# Window management

`<C-W> <C-R>` to swap the positions of the current splits

`<C-W>+` **increase** the height of current window

`<C-W>-` **decrease** the height of current window

`<C-j/k/h/l>` change the position of active window

`<C-=>` make all windows equal size

# Spell check

`:set spell` to turn on spell check (mapped to leader s)

`zg` to add to personal dictionary

`zug` to delete from personal dictionary

# FZF plugin

`:FZF` display a pop up window for fzf, and opens the selected file in the
current buffer.

`:Files` same with `fzf` but shows a preview of the selected file (*mapped to
control-p*)

`:Buffer` similar with above 2, but opens the file in a new buffer

`:Rg`(ripgrep) search within files for matching string

`:Lines` searches through all the buffers currently open for a matching string

# Customizing vim highlighting colors

Go to `/usr/share/nvim/runtime/syntax/syncolor.vim` to change syntax highlighting colors

# Using tabs

```vim
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

### capitalization

`gu` changes letters to lowercase
`gU` changes letters to capital

## skip a block of Code

{ skips a block of code going downwards. } skips upwards

## indenting

<< indents left. >> indents right

## auto indent

=i{ to auto indent a block of code in `{}`, when the indentation is inconstant

## detect file type

`:filetype detect` will detect the current file type

## Screen navigations

gg to top of document

G to bottom of document

T(top) to top of screen

M(middle) to middle of screen without moving the text

L(lower) to bottom of screen, without moving the text

^ to the first **non white space character** on that line

0 to the beginning of the current line, **including white space characters.**

g\_ go to the last **non white space character** on that line

$ to the end of the current line, **including white space characters.**

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

To open vim and run a vim command at the same time (ie in a script). Run `vim
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

# Sessions

## Creating sessions

In vim, `:mksession <session name.vim` to create a session

`:mksession` can be shortened to `:mks`

## Opening sessions

When opening vim, do `vim -S <session name>` to open that session

Or within vim, `:source <path to session>` to open session

# Formatters

## clang-format

`clang-format-12`, the newest clang formatter. Installed through apt. Since the
formatting is handled through null-ls, which looks for a `clang-format` binary,
the `clang-format-12` binary in `/usr/bin/clang-format-12` was renamed to
`clang-format`, to make null-ls recognize it.

It looks for a `.clang-format` file in the root directory, which contains
styling options. The
[documentation](https://clang.llvm.org/docs/ClangFormatStyleOptions.html) can be
found here.


