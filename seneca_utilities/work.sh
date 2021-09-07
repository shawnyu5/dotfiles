#!/bin/bash
#purpose of this file: create a tmux session at a specific directory depending on user input
#Date: 2021-05-29
#---------------------------------

shopt -s expand_aliases
source ~/.zsh_aliases

#read -p "What class will this be? (1.OOP, 2.SYD, 3.CUL) " CLASS

select CLASS in 'WEB' 'DBS' 'PSY'; do

    case $CLASS in
        "WEB"|"1")

            read -p "which workshop? (1-9) For final project, enter 10: " WORKSHOPNUMBER

            #cd to web directory
            cdweb

            #make sure workshop number is less than 9
            if [[ $WORKSHOPNUMBER -le 9 ]]; then
                read -p "part 1 or 2? " WORKSHOPPART

                cd workshops/ws_$WORKSHOPNUMBER
                SESSION_NAME="oop_ws$WORKSHOPNUMBER"
                #create new session
                tmux new-session -d -s $SESSION_NAME
                tmux rename-window -t 0 'code'
                tmux send-keys -t 0 cdoop Enter
                if [[ -z $WORKSHOPPART ]]; then
                    tmux send-keys -t 0 "cd workshops/ws_$WORKSHOPNUMBER" Enter
                else
                    tmux send-keys -t 0 "cd workshops/ws_$WORKSHOPNUMBER/part_$WORKSHOPPART" Enter
                fi
                tmux send-keys -t 0 "clear" Enter
                #new window for instructions
                tmux new-window -t $SESSION_NAME:2 -n 'instructions'
                tmux send-keys -t 2 " cdoop" Enter
                tmux send-keys -t 2 "cd workshops/ws_$WORKSHOPNUMBER && nvim readme.md" Enter
            else
                read -p "Which milestone? (1-3)? MS_" MILESTONE
                cd final_project/MS$MILESTONE
                SESSION_NAME="oop_final_MS$MILESTONE"
                tmux new-session -d -s $SESSION_NAME
                tmux rename-window -t 0 'code'
                #new window for instructions
                tmux new-window -t $SESSION_NAME:2 -n 'instructions'
                tmux send-keys -t 2 " cdoop && cd final_project && nvim readme.md" Enter
            fi

    #new window for notes
    tmux new-window -t $SESSION_NAME:1 -n 'notes'
    #tmux send-keys -t 'notes' oopnotes Enter
    tmux attach-session -t $SESSION_NAME:0

    break
;;

    "DBS"|"2")

        #echo SYD
        read -p "1.lab or 2.week: " DEST

        if [[ $DEST == "1" || $DEST == "lab" ]]; then
            cdsyd
            tmux new-session -d -s syd_lab
            tmux send-keys -t 0 cdsyd Enter
            tmux send-keys -t 0 "cd labs" Enter
            tmux send-keys -t 0 "clear" Enter
            tmux attach-session -t syd_lab
        elif [[ $DEST == "2" || $DEST == "week" ]]; then
            cdsyd
            read -p "which week? (1-13) week_" WEEKNUMBER
            tmux new-session -d -s syd_weekly_notes
            tmux send-keys -t 0 cdsyd Enter
            tmux send-keys -t 0 "cd week_$WEEKNUMBER" Enter
            tmux send-keys -t 0 "clear" Enter
            tmux attach-session -t syd_weekly_notes
        fi
        break

    ;;

    "PSY"|"3")
        #echo CUL
        read -p "which week? (1-13)." WEEKNUMBER
        cdpsy

        tmux new-session -d -s psy_week_${WEEKNUMBER}
        tmux send-keys -t 0 "cd week_$WEEKNUMBER" Enter
        tmux send-keys -t 0 "clear" Enter
        tmux attach-session -t psy_week_${WEEKNUMBER}
        break
    ;;

    *)

        echo "invalid choice"


    esac
done
