# make sure npm is intalled
npm -v >> /dev/null
if [[ $? -ne 0 ]]; then
   echo Please install npm
   exit
fi

# make sure script is ran with root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#######################################
# prompt user with a prompt, and run command passed in
# Globals:
#   SERVER
# Arguments:
#   the server name to install
#   the command to install the server
#######################################
install() {
   SERVER=$1
   COMMAND=$2

   read -p "Install ${SERVER}? Y/n: " INSTALL
   if [[ $INSTALL == "y" || $INSTALL == "" ]]; then
      eval $COMMAND
   fi
}

install "Gopls" "sudo pacman -S gopls"
install "clangd" "sudo pacman -S clang"
install "bash language server" " sudo pacman -S bash-language-server"
install "html / json" "npm i -g vscode-langservers-extracted"
install "tsserver" "npm install -g typescript typescript-language-server"
install "lua language server" "sudo pacman -S lua-language-server"
install "pyrigh" "sudo pacman -S pyright"
install "angularls" "npm install -g @angular/language-server"
install "gopls" "sudo pacman -S gopls"
install "dockerls" "yay -S docker-ls"
install "marksman" "yay -S marksman-bin"
