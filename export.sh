#!/bin/bash
#purpose of this file: updates config files on current system
#Date: 2021-05-21
#---------------------------------

git pull

#vim config
cp config/nvim/init.vim ~/.config/nvim/init.vim && echo "init.vim exported"
cp -r config/nvim/settings ~/.config/nvim/ && echo "nvim settings directory exported"
cp -r config/nvim/lua ~/.config/nvim/ && echo "nvim lua directory exported"
cp -r config/nvim/UltiSnips ~/.config/nvim/ && printf "snips exported\n\n"

#tmux.conf
cp  tmux.conf ~/.tmux.conf && echo "tmux config exported"

#task worrior config
cp task_worrior/taskrc  ~/.taskrc && echo "task config exported"

# zsh config
cp zsh_aliases_general ~/.zsh_aliases && echo "zsh_aliases exported"
