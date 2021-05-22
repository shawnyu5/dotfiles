#!/bin/bash
#purpose of this file: imports config files to be commited
#Date: 2021-05-21
#---------------------------------

#init.vim
cp -v ~/.config/nvim/init.vim config/nvim/init.vim

#tmux config
cp -v ~/.tmux.conf tmux.conf

#taskrc
cp -v ~/.taskrc task_worrior/taskrc

