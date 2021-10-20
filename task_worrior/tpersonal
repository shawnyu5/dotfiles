#!/bin/bash
#purpose of this file: add a task to project seneca with due date
#Date: 2021-05-16
#---------------------------------

#context:school
#project: class name or lecture
#tags: for each class
task calendar

if [[ -z $1 ]]; then
	read -p "task name: " NAME
else
	NAME="$@"
fi

read -p "due date: " DATE

task add "${NAME}" \
	project:personal\
	due:$DATE \

# task project:personal
