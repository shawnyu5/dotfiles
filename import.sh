#!/bin/bash
#purpose of this file: imports config files to be commited
#Date: 2021-05-21
#---------------------------------

#vim config
cp ~/.config/nvim/init.vim config/nvim/init.vim
cp -r ~/.config/nvim/settings/ config/nvim && echo "vim config imported"

#tmux config
cp ~/.tmux.conf tmux.conf && echo "tmux config imported"

#taskrc
cp ~/.taskrc task_worrior/taskrc && echo "task config imported"

#zsh config
cp ~/.zshrc zsh_config/zshrc
cp ~/.zsh_aliases zsh_config/zsh_aliases && echo "zsh config imported"

git status
