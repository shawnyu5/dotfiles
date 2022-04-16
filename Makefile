help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: ## Create all symlinks
	ln -svf ~/personal/.config/i3 ~/.config/
	ln -svf ~/personal/.config/kitty ~/.config/kitty
	ln -svf ~/personal/.config/neofetch/ ~/.config/
	ln -svf ~/personal/.config/i3blocks ~/.config/i3blocks
	ln -svf ~/personal/.config/rofi ~/.config/rofi
	ln -svf ~/personal/.gitconfig ~/.gitconfig
	ln -svf ~/personal/.zshrc ~/.zshrc
	ln -svf ~/personal/.zsh_aliases ~/.zsh_aliases
	ln -svf ~/personal/.zsh_aliases-custom ~/.zsh_aliases-custom
	ln -svf ~/personal/.clang-format ~/.clang-format
	ln -svf ~/personal/.bashrc ~/.bashrc
	ln -svf ~/personal/.bash_logout ~/.bash_logout
	ln -svf ~/personal/.bash_profile ~/.bash_profile
	ln -svf ~/personal/.bash_history ~/.bash_history
	ln -svf ~/personal/.tmux.conf ~/.tmux.conf
	ln -svf ~/personal/.taskrc ~/.taskrc


backup: ## backup all pacman packages
	mkdir -p ./backup/
	pacman -Qnq > ./backup/pacman-packages.txt
	pacman -Qqem > ./backup/aur-packages.txt

install_pacman: ## install all pacman packages
	pacman -S --needed $(cat ./backup/pacman-packages.txt)
