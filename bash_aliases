#| |__   __ _ ___| |__     __ _| (_) __ _ ___ 
#| '_ \ / _` / __| '_ \   / _` | | |/ _` / __|
#| |_) | (_| \__ \ | | | | (_| | | | (_| \__ \
#|_.__/ \__,_|___/_| |_|  \__,_|_|_|\__,_|___/

#deleteing start alias
unalias start 2> /dev/null 

alias bd=". bd -si"

#running valgrind
alias vg="valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --track-origins=yes" 

#make copying always recursive
alias cp="cp -r"

#make zip always recursive
alias zip="zip -r"

#make rm-r always prompt
alias rm="rm -I"

#opening github desktop
alias gitd="github-desktop &"

#shortcut to google chrome
#alias chrome="google-chrome"

#show battery percentage
alias battery="acpi"

#opening vimrc
alias vimrc="vim ~/.config/nvim/init.vim"

#have ls list directories first 
alias ls="ls --group-directories-first --color=auto"

#opening vim
alias v="vim"

#open all cpp and .h files in the current directory in vim and auto tab them
alias va="vim +':tab all' *.cpp *.h" 

#r to open ranger
alias r="ranger"

#updating the source bashrc file
alias sr="source ~/.bashrc"

#editing bashrc file via vim
alias bashrc="vim ~/.bashrc"

#editing .bash_alias file
alias bash_alias="vim ~/.bash_aliases"

#opening neomutt
alias mail="neomutt"

#watch starwars
alias starwars="telnet towel.blinkenlights.nl"

#go to oop directory 
alias cdoop="cd ~/seneca/semester_3/OOP_345"

#going to CUL directory
alias cdcul="cd ~/seneca/semester_3/CUL_485_movies_and_morality"

#going to SYD directory
alias cdsyd="cd ~/seneca/semester_3/SYD_366_Softwarer_Analysis_and_Design-1"

#auto complete in tmux
alias tma="tmux attach -t $1"
if [ -f ~/.tmux_completion ]; then
    . ~/.tmux_completion
fi

#taskworrior aliases
#=====================================

#t for task
alias t="task"

#editing taskrc
alias trc="vim ~/.taskrc"

#==========================

#for starting any file(s)
function start
{
    if [ $# -eq 0 ]; then
        echo "Opening current directory..."
        xdg-open . 2> /dev/null
    else
        for current in "$@"
        do 
            echo "opening $current..."
            xdg-open "$current" 2> /dev/null

        done
    fi
}

#to open all .h and .cpp files in a new vs code window
function codea
{
	cpp=(`find ./ -maxdepth 1 -name "*.cpp"`)
	h=(`find ./ -maxdepth 1 -name "*.h"`)
	
	if [ ${#cpp[@]} -gt 0 ]; then 
		code -n ${cpp[*]}   
	else 
		echo 'no .cpp file(s) present'
	fi

	if [ ${#h[@]} -gt 0 ]; then 
		code ${h[*]}
	else
		echo 'no .h file(s) found'

	fi

}
#function oopDeclaration
#{
#    declaration="/mnt/c/Users/Shawn/OneDrive - Seneca/FUN/bash/oop_declaration/OOPDeclaration.txt"
#
#
#    for current in "$@"
#    do 
#        touch tmp.txt
#        #put the dest file content into tmp file
#        cat "$current" > tmp.txt
#
#        #adding header
#        cat "$declaration" > "$current" 
#
#        #putting orginal file back after header. 
#        cat tmp.txt >> "$current"
#        rm tmp.txt >/dev/null
#
#        echo "declaration added to file: $current"
#    done
#}

#creates a Excute bash file to first compile the program files being passed in as arguments
function excfile
{
	read -p "name of the output file: " OUTPUT
        autoexpect "$1" 

        #replace the last line with interact
        cp script.exp script.exp.tmp
        sed '$ d' script.exp.tmp > script.exp
        rm -f script.exp.tmp >/dev/null

        echo "interact" >> script.exp
        
        mv script.exp "autocompile_$OUTPUT".exp && echo -e "\nscript.exp renamed to autocompile_$OUTPUT.exp"

}

#list all files in current directory using fzf
#function se
#{
#	du -a $(pwd) | awk '{print $2}' | fzf | xargs -r $EDITOR
#}

#mdless any cheatsheet in cheatsheet directory
function vcheat 
{
	du -a ~/cheatsheets/*.md | awk '{print $2}' | fzf | xargs mdless
}

#edit any cheatsheet in cheatsheet directory
function echeat
{
	du -a ~/cheatsheets/*.md | awk '{print $2}' | fzf | xargs $EDITOR

}

#make a directory and go into that directory
function mkdirin { mkdir $1 && cd $1; }

#move functions

function general_move
{
	mv -v "$@" && cd $_

}

function mvoop
{
	if [[ $1 == "-"* ]]; then
#		echo "if entered"
		DEST=$(echo "$1" | sed 's/-//') #remove - in destination path
		shift 1
		general_move "$@" "/home/shawn/seneca/semester_3/OOP_345/$DEST"
	else
		echo "else entered"
		DEST="/home/shawn/seneca/semester_3/OOP_345"
		general_move "$@" "$DEST" 
	fi
}

