cd "$1"
cd $(find . -type d | fzf) && ls -l
pwd
