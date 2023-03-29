#  _______| |__  _ __ ___ 
# |_  / __| '_ \| '__/ __|
#  / /\__ \ | | | | | (__ 
# /___|___/_| |_|_|  \___|

# Set up the prompt

#autoload -Uz promptinit
#promptinit
#prompt adam1

setopt histignorealldups sharehistory

#allow for piping to /dev/null
unsetopt multios

#export TERM="screen-256color"

fpath=(~/personal/custom_completion $fpath)

# allow auto completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -i
_comp_options+=(globdots)		# Include hidden files.

# Enable colors and change prompt:
autoload -U colors && colors

export TERM="kitty"
export BROWSER="google-chrome-stable"
export GOPATH=$HOME/gopath

precmd_functions=""

#luke smith ranbow colours
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '🌲%b'
precmd() { vcs_info }
# Enable substitution in the prompt.
setopt prompt_subst


# NOTE: prompt must be wrapped in single quotes for the git stuff to work
PROMPT='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}] %{$fg[green]%}🔨%j%E %{$fg[cyan]%}${vcs_info_msg_0_}
%{$fg[cyan]%}$%{$reset_color%}%b '

#zsh prompt script
#source /home/shawn/personal/zsh_config/prompt_adam1_setup.zsh

#orginal
#PROMPT="%K{blue}%n@%m%k %B%F{cyan}%(4~|...|)%3~%F{white} %# %b%f%k"

#PROMPT='%~ $# '
#PS1='%F{blue}%1~%f %# '


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

function cd_with_fzf
{
    cd "$(find ~ -type d \( -name "*" ! -iname ".*" \) | fzf --bind="space:toggle-preview")" && pwd && ls --group-directories-first --color=auto
}
#create a witget using function above
zle -N cd_with_fzf
#bind control f to witget
bindkey '^F' cd_with_fzf

#if remaps.sh exists, call it
# if [[ -f ~/remaps.sh ]]; then
    # . ~/remaps.sh
# fi

if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

SENECA_MATRIX='hyu126@matrix.senecacollege.ca'

export IGNOREEOF=10

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#setting default editor to neovim 
export EDITOR='nvim'
export VISUAL="$EDITOR"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

#load alias file
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

if [ -f ~/.zsh_aliases-custom ]; then
    . ~/.zsh_aliases-custom
fi

# export PATH="$PATH:/home/shawn/scripts/template-file-creation"
export PATH="$PATH:$HOME/.local/bin/:$HOME/gopath/bin/"
export PATH="$PATH:/opt/mssql-tools/bin"
export PATH=$PATH:"/usr/local/go/bin" # go

# export PATH="$PATH:/usr/local/bin/java-language-server/dist/linux/bin/"

export JAVA_HOME="/usr/lib/jvm/default-runtime"
# export PATH=":$PATH:$JAVA_HOME/bin" # java
export JDTLS_HOME="/usr/bin/jdt/"
export ansible_python_interpreter=/usr/bin/python3

# increase ulimit
# ulimit -n 6000

alias luamake=/home/shawn/lua-language-server/3rd/luamake/luamake
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:';
export LS_COLORS

## Enable substitution in the prompt.
#setopt prompt_subst

# Config for prompt. PS1 synonym.
#prompt='%2/ $(git_branch_name) > '

#syntax highlighting. MUST BE ON THE BOTTOM OF THE FILE
#source /home/shawn/personal/zsh_config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


#auto suggestions
source $HOME/personal/linux/zsh_tools/zsh-autosuggestions/zsh-autosuggestions.zsh

# Change cursor shape for different vi modes.
#function zle-keymap-select {
  #if [[ ${KEYMAP} == vicmd ]] ||
     #[[ $1 = 'block' ]]; then
    #echo -ne '\e[1 q'
  #elif [[ ${KEYMAP} == main ]] ||
       #[[ ${KEYMAP} == viins ]] ||
       #[[ ${KEYMAP} = '' ]] ||
       #[[ $1 = 'beam' ]]; then
    #echo -ne '\e[5 q'
  #fi
#}
#zle -N zle-keymap-select
#zle-line-init() {
    #zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    #echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
## Find and set branch name var if in git repository.
#function git_branch_name()
#{
  #branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  #if [[ $branch == "" ]];
  #then
    #:
  #else
    #echo '- ('$branch')'
  #fi
#}


