#!/bin/bash
#purpose of this file:updates config files on current system
#Date: 2021-05-21
#---------------------------------

#vim config
cp config/nvim/init.vim ~/.config/nvim/init.vim && echo "init.vim exported"
cp -r config/nvim/settings ~/.config/nvim/ && echo "nvim settings directory exported"

#tmux.conf
cp  tmux.conf ~/.tmux.conf && echo "tmux config exported"
