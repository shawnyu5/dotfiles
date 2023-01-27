#!/bin/bash
#######################################
#  Add a seneca task to task worrior  #
#######################################

task calendar

YEAR=$(date +%Y)
MONTH=$(date +%m)

if [[ -z $1 ]]; then
   read -p "task name: " NAME
else
   NAME="$@"
fi

# TODO: add common due dates to choose from. ie midnight
read -p "due date: $YEAR-$MONTH-" DATE

CLASS=$(echo -e "C#\nBCI\ndevops\nPRJ\nCo-op" | fzf)

task add "${NAME}" project:$CLASS\
   due:$YEAR-$MONTH-$DATE \
   +seneca

task

# commit tasks to git
cd ~/personal/
git add .task
git commit -m "sync task worrior tasks"
git push
