#!/bin/bash
#purpose of this file:updates config files on current system
#Date: 2021-05-21
#---------------------------------

#vim config
#cp -v config/nvim/init.vim ~/.config/nvim/init.vim
cp -r config/nvim/settings ~/.config/nvim/ && echo "nvim settings directory exported"

#tmux.conf
cp  tmux.conf ~/.tmux.conf && echo "tmux config exported"

#read -p "sync bash_alias? (y/n): " ALIAS
#
#if [[ ALIAS == 'y' ]]; then
#	vim -d bash_alias ~/.bash_alias
#fi

