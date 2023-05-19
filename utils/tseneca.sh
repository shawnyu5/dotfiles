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

# dateSelection=($(seq 1 31))
# add all dates of current month
for i in {01..31}; do
   dateSelection+=("$YEAR-$MONTH-$i")
done

MONTH=$((MONTH+1))
for i in {01..31}; do
   dateSelection+=("$YEAR-0$MONTH-$i")
done
dateSelection+=("tomorrow")
dateSelection+=("today")
dateSelection+=("yesterday")
dateSelection+=("mon")
dateSelection+=("tue")
dateSelection+=("wed")
dateSelection+=("thu")
dateSelection+=("fri")
dateSelection+=("sat")
dateSelection+=("sun")
DATE=$(printf '%s\n' "${dateSelection[@]}" | fzf --prompt "Due date: ")
read -e -p "due date: " -i $DATE DATE

CLASS=$(echo -e "data_warehousing\nbig_data\nadvanced_java" | fzf --prompt "Class: ")

task add "${NAME}" project:$CLASS\
   due:$DATE \
   +seneca

task

# commit tasks to git
cd ~/personal/
git add .task
git commit -m "sync task worrior tasks"
git push
