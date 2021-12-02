#!/bin/bash
#purpose of this file: import bash config files
#Date: 2021-06-16
#---------------------------------

cp ~/.bashrc ./bashrc && echo "bashrc imported"
cp ~/.bash_aliases ./bash_aliases && echo "bash aliases imported"

cp ~/.zsh_aliases-custom zsh_aliases-custom && echo "custom zsh aliases imported"
cp ~/.zshrc zshrc && echo "zshrc imported"


