#!/bin/bash
#purpose of this file: commit and push this repo
#Date: 2021-05-19 
#---------------------------------

read -p "commit message: " MESSAGE
read -p "commit description: " DESCRIPTION

if [[ -z $MESSAGE ]]; then
	MESSAGE="update"
fi

git add -A
git commit -m "$MESSAGE" -m "$DESCRIPTION"
git push origin main && echo -e "\n comitted"



