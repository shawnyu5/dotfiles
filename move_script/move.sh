#!/bin/bash
#purpose of this file: move function achieved using fzf
#Date: 2021-07-28
#---------------------------------

DEST=$(ls -d $1/*/ | fzf)
shift
mv -v "$@" "$DEST"
cd "$DEST"
echo "$DEST"
