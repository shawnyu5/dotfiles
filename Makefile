help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

import: ## Import all configs from system
	$(PWD)/import.sh

export: ## Export all configs to system
	$(PWD)/export.sh

import_linux: ## import all linux configs
	$(PWD)/linux/import.sh

export_linux: ## export all linux configs
	$(PWD)/linux/export.sh

init: ## Create all symlinks
	ln -svf ~/personal/.config/i3 ~/.config/
	ln -svf ~/personal/.config/kitty ~/.config/kitty
	ln -svf ~/personal/.config/neofetch/ ~/.config/
	ln -svf ~/personal/.config/i3blocks ~/.config/i3blocks
	ln -svf ~/personal/.config/rofi ~/.config/rofi
	ln -svf ~/personal/.gitconfig ~/.gitconfig

backup: ## backup all pacman packages
	mkdir -p ./backup/
	pacman -Qnq > ./backup/pacman-packages.txt
	pacman -Qqem > ./backup/aur-packages.txt
