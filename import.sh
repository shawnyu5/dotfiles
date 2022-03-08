#!/bin/bash
#purpose of this file: imports config files to be commited
#Date: 2021-05-21
#---------------------------------

#vim config
cp -r ~/.config/nvim/ config/ && echo "nvim directory imported"
rm config/nvim/plugin/packer_compiled.lua
cp -r ~/.config/kitty/ ./config/ && echo "Kitty config imported"
cp ~/.config/compton.conf ./config/ && echo "compton config imported"
cp -r ~/.config/i3blocks/ ./config/ && echo "i3blocks config imported"
cp -r ~/.config/i3/ ./config/ && echo "i3 config imported"
cp -r ~/.config/rofi/ ./config/ && echo "rofi config imported"
cp -r ~/.task/ ./task && echo "taskworrior config imported"

#tmux config
cp ~/.tmux.conf tmux.conf && echo "tmux config imported"

#taskrc
cp ~/.taskrc task_worrior/taskrc && echo "task config imported"

# general zsh_alias
cp ~/.zsh_aliases zsh_aliases_general && echo "general zsh aliases imported"

git status

read -p "Push to gitHub? [Y/n]: " CHOICE
CHOICE="${CHOICE:-Y}"

if [[ $CHOICE == 'y' || $CHOICE == 'Y' ]]; then
    git pull
    git add -A
    git commit
    git push origin main
fi

