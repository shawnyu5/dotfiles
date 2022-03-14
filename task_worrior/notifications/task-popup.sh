#!/bin/bash
# found this code on http://taskwarrior.org/projects/1/wiki/Export-htmlpy
# For cron: */30 * * * * DISPLAY=:0.0 /home/User/configs/TaskNotify.sh
# Requires linux with notify-send and canberra-gtk-play which are default on Ubuntu

get_active_tasks() {
   while [[ true ]]; do
      head_value=-3
      task=$(task active | tail -n +4 | head -n ${head_value})
      echo task
   done
}

num=`task active | wc -l`
if [ $num -gt "1" ]
then
   task=$(task active | sed -e '1,3d')
   notify-send "$task"
   # notification=$(task active | tail -n +4 | head -n -3)
   # notification=$(echo $notification | cut -d " " -f5-)
   # echo $notification
   # notify-send "Active Tasks: ${notification}"
   # canberra-gtk-play --file=/usr/share/sounds/gnome/default/alerts/drip.ogg
else
   notify-send "No Active Tasks" "C'mon! What are you doing?"
   # canberra-gtk-play --file=/usr/share/sounds/ubuntu/stereo/dialog-question.ogg
fi


