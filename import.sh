#!/bin/bash
#purpose of this file: imports config files to be commited
#Date: 2021-05-21
#---------------------------------

#vim config
cp ~/.config/nvim/init.vim config/nvim/init.vim && echo "vim settings imported"
cp -r ~/.config/nvim/settings/ config/nvim && echo "init.vim imported"

#tmux config
cp ~/.tmux.conf tmux.conf && echo "tmux config imported"

#taskrc
cp ~/.taskrc task_worrior/taskrc && echo "task config imported"

git status

read -p "Push to gitHub? [Y/n]: " CHOICE

if [[ $CHOICE == 'y' || $CHOICE == 'Y' ]]; then
    git add -A
    git commit
    git push origin main
fi

