#!/bin/sh
##############################################
#  sync task worrior tasks to dotfiles repo  #
##############################################


cd ~/personal
git add .task
git commit -m "sync .task"
git push
