help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: set_default_shell neovim ## Create all symlinks
	ln -svf ~/personal/.config/i3 ~/.config/
	ln -svf ~/personal/.config/kitty ~/.config/
	ln -svf ~/personal/.config/neofetch/ ~/.config/
	ln -svf ~/personal/.config/i3blocks ~/.config/
	ln -svf ~/personal/.config/rofi ~/.config/
	ln -svf ~/personal/.config/nvim ~/.config/
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
	ln -svf ~/personal/wallpapers ~/Pictures/wallpaper
	# Ultralist
	# ln -svf ~/personal/.todos.json ~/.todos.json


backup: FORCE ## backup all pacman packages
	rm -rf ./backup
	mkdir -p ./backup/
	pacman -Qnq | grep -v "endeavouros*" > ./backup/pacman-packages.txt
	pacman -Qqem | grep -v "endeavouros*" > ./backup/aur-packages.txt

pacman: ## install all pacman packages
	pacman -S - < ./backup/pacman-packages.txt

yay: ## install all aur packages
	yay -S - < ./backup/aur-packages.txt

FORCE: ;

docker: ## install and set up docker
	sudo pacman -S --needed docker docker-compose
	sudo systemctl enable docker
	sudo systemctl start docker
	sudo chmod 666 /var/run/docker.sock

neovim: ## set up neovim with my config (WARNING: this will overwrite your current config)
	ln -svf ~/personal/.config/nvim ~/.config/nvim

tmux_plugin_manager:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

set_default_shell: ## set default shell to zsh
	chsh -s $$(which zsh)
