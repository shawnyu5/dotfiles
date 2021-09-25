#!/bin/bash
#purpose of this file: contains general seneca movement utilities
#Date: 2021-09-07
#---------------------------------

# takes directory path as arg 1, the rest are files to be moved
function custom_move
{
    DEST=$(find "$1" -type d | fzf)
    # remove directory path from argument list
    shift 1
    mv -v "$@" "$DEST"
    cd "$DEST"
}

custom_move $@
