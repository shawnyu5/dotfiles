#!/bin/bash
#purpose of this file: create a tmux session at a specific directory depending on user input
#Date: 2021-05-29
#---------------------------------

read -p "What class will this be? (1.OOP, 2.SYD, 3.CUL) " CLASS

case $CLASS in
	"OOP"|"1")
	{
		read -p "which workshop? (1-9): " WORKSHOPNUMBER
		tmux new-session -d -s oop_$WORKSHOP
		tmux send-keys -t 0 cdoop Enter
		tmux send-keys -t 0 "cd workshops/ws_$WORKSHOPNUMBER" Enter
		tmux attach-session -t oop_$WORKSHOPNUMBER
	};;

	"SYD"|"2")
	{
		#echo SYD
		read -p "1.lab or 2.week: " DEST

		if [[ $DEST == "1" || $DEST == "lab" ]]; then
			tmux new-session -d -s syd_lab
			tmux send-keys -t 0 cdsyd Enter
			tmux send-keys -t 0 "cd labs" Enter
			tmux attach-session -t syd_lab
		elif [[ $DEST == "2" || $DEST == "week" ]]; then
			read -p "which week? (1-13) week_" WEEKNUMBER
			tmux new-session -d -s syd_weekly_notes
			tmux send-keys -t 0 cdsyd Enter
			tmux send-keys -t 0 "cd week_$WEEKNUMBER" Enter
			tmux attach-session -t syd_weekly_notes
		fi

	};;

	"CUL"|"3")
	{
		#echo CUL
		read -p "which week? (1-13). For essay, enter 14 or essay. week_" WEEKNUMBERCUL
		echo week number is $WEEKNUMBERCUL
		if [[ "$WEEKNUMBERCUL" == "14" || "$WEEKNUMBERCUL" == "essay" ]]; then
			#echo if statement entered
			tmux new-session -d -s cul_essay
			tmux send-keys -t 0 cdcul Enter
			tmux send-keys -t 0 "cd essay" Enter
			tmux send-keys -t 0 "vim outline.md" Enter
			tmux attach-session -t cul_essay
		else
			tmux new-session -d -s cul_weekly_notes
			tmux send-keys -t 0 cdcul Enter
			tmux send-keys -t 0 "cd week_$WEEKNUMBER" Enter
			tmux attach-session -t cul_weekly_notes
		fi

	};;
esac

