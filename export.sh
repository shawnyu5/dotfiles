#!/bin/bash
#purpose of this file:updates config files on current system
#Date: 2021-05-21
#---------------------------------

#init.vim
cp -v config/nvim/init.vim ~/.config/nvim/init.vim

#tmux.conf
cp -v tmux.conf ~/.tmux.conf

#read -p "sync bash_alias? (y/n): " ALIAS
#
#if [[ ALIAS == 'y' ]]; then
#	vim -d bash_alias ~/.bash_alias
#fi

