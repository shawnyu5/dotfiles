#!/bin/bash
#purpose of this file: move function achieved using fzf
#Date: 2021-07-28
#---------------------------------

function mvoop
{
    DEST=$(ls -d /home/shawn/seneca/semester_3/OOP_345_Object-Oriented_Programming_Using_C++/*/ | fzf)
    mv -v "$@" "$DEST"
    cd "$DEST"
}

function mvsyd
{
    DEST=$(ls -d /home/shawn/seneca/semester_3/SYD_366_Softwarer_Analysis_and_Design-1/*/ | fzf)
    mv -v "$@" "$DEST"
    cd "$DEST"
}

function mvcul
{
    DEST=$(ls -d /home/shawn/seneca/semester_3/CUL_485_movies_and_morality/*/ | fzf)
    mv -v "$@" "$DEST"
    cd "$DEST"
}




