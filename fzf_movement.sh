#!/bin/bash
#purpose of this file: cd to anywhere with fzf
#Date: 2021-08-09
#---------------------------------

cd $HOME && cd "$(find . -not -path "*/\.*" -name "*" | fzf --bind="space:toggle-preview")" && pwd && ls




