#!/bin/bash
#purpose of this file: imports config files to be commited
#Date: 2021-05-21
#---------------------------------

#vim config
cp -r ~/.config/nvim/ config/ && echo "nvim directory imported"
rm config/nvim/plugin/packer_compiled.lua
# cp -r ~/.config/nvim/init.vim config/nvim && echo "init.vim imported"
# cp -r ~/.config/nvim/UltiSnips/ config/nvim/ && echo "util snips imported"
# cp -r ~/.config/nvim/settings/ config/nvim/ && echo "settings imported"
# cp -r ~/.config/nvim/spell/ config/nvim/ && echo "spell directory imported"
# cp -r ~/.config/nvim/lua/ config/nvim/ && echo "lua directory imported"

#tmux config
cp ~/.tmux.conf tmux.conf && echo "tmux config imported"

#taskrc
cp ~/.taskrc task_worrior/taskrc && echo "task config imported"

# general zsh_alias
cp ~/.zsh_aliases zsh_aliases_general && echo "general zsh aliases imported"

git status

read -p "Push to gitHub? [Y/n]: " CHOICE

if [[ $CHOICE == 'y' || $CHOICE == 'Y' ]]; then
    git pull
    git add -A
    git commit
    git push origin main
fi

