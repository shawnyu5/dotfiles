          --_             _
 --___  ___| |_ ___      | |_   _  __ _
--/ __|/ _ \ __/ __|     | | | | |/ _` |
--\__ \  __/ |_\__ \  _  | | |_| | (_| |
--|___/\___|\__|___/ (_) |_|\__,_|\__,_|


vim.o.relativenumber = true;
vim.o.number = true;

--set leader key to space
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.nottimeout = true
vim.g.ttimeoutlen = 600
vim.g.timeoutlen = 1000

--make tab only 4 spaces
vim.g.tabstop = 4
vim.g.softtabstop = 4
vim.g.expandtab = true

--always show tabs
vim.g.showtabline = 2
vim.g.cursorline = true
