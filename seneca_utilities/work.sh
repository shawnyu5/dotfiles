#!/bin/bash
#purpose of this file: create a tmux session at a specific directory depending on user input
#Date: 2021-05-29
#---------------------------------
shopt -s expand_aliases
#setopt aliases
source ~/.bashrc
source ~/.bash_aliases

function web_course
{
    select CHOICE in "weeks" "assignment"; do
        #cd to web directory
        cdweb

        #echo choice is $CHOICE
        if [ "$CHOICE" = "weeks" ]; then
            read -p "Which week? (1-13): " WEEKNUMBER
            tmux new-session -d -s web_week_${WEEKNUMBER}
            tmux send-keys -t 0 "cd week_${WEEKNUMBER}" Enter
            tmux send-keys -t 0 "clear" Enter
            tmux attach-session -t web_week_${WEEKNUMBER}
            exit 0
        elif [ "$CHOICE" = "assignment" ]; then
            read -p "Which assignment (1-4): " ASSIGNMENT
            tmux new-session -d -s web_assignment_${ASSIGNMENT}
            tmux send-keys -t 0 "cd assignment_${ASSIGNMENT}" Enter
            tmux send-keys -t 0 "clear" Enter
            tmux attach-session -t web_assignment_${ASSIGNMENT}
            exit
        else
            echo "invalid choice"
        fi
    done
}

function dbs_course
{
    read -p "1.lab or 2.week: " DEST

    if [[ $DEST == "1" || $DEST == "lab" ]]; then
        cddbs
        tmux new-session -d -s dbs_lab
        tmux send-keys -t 0 cddbs Enter
        tmux send-keys -t 0 "cd labs" Enter
        tmux send-keys -t 0 "clear" Enter
        tmux attach-session -t dbs_lab
    elif [[ $DEST == "2" || $DEST == "week" ]]; then
        cddbs
        read -p "which week? (1-13) week_" WEEKNUMBER
        tmux new-session -d -s dbs_lab
        tmux send-keys -t 0 cddbs Enter
        tmux send-keys -t 0 "cd week_$WEEKNUMBER" Enter
        tmux send-keys -t 0 "clear" Enter
        tmux attach-session -t dbs_lab
    fi
    exit
}

function psy_course
{
    read -p "which week? (1-13): " WEEKNUMBER
    cdpsy
    tmux new-session -d -s psy_week_${WEEKNUMBER}
    tmux send-keys -t 0 "cd week_$WEEKNUMBER" Enter
    tmux send-keys -t 0 "clear" Enter
    tmux attach-session -t psy_week_${WEEKNUMBER}
    exit

}

select CLASS in 'WEB' 'DBS' 'PSY'; do
    case $CLASS in
        "WEB")
            web_course
            ;;

        "DBS")
            dbs_course
            ;;

        "PSY")
            psy_course
            ;;
        *)
            echo "invalid choice"
            ;;
    esac
done
