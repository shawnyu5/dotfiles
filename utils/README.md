# Utilities

A set of utility scripts for a new system

## lsp_install.sh

A script to install all neovim builtin lsp servers.

## change_wallpaper.sh

Load all wall papers though fzf in `~/Pictures/wallpaper/`, and prompt for selection

`exec_always feh --randomize --bg-fill /home/Shawn/Pictures/wallpaper/*`

## lsp_install.yml

A Ansible play book to install all needed lsp servers

To install all needed Ansible modules, run `ansible-galaxy collection install -r requirements.yml`

To install all lsp servers, run `ansible-playbook lsp_install.yml`
