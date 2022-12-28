-- placed here for easy access
vim.opt.relativenumber = true

vim.g.mapleader = " "
-- get rid of eob fill chars
vim.opt.fillchars = { eob = " " }
vim.cmd([[set syntax=off]])

--- source a vim file
---@param file string file path to source
local function source(file)
	vim.cmd("source " .. file)
end

source("~/.config/nvim/settings/maps.vim")
source("~/.config/nvim/settings/sets.vim")
require("shawn.lazy")
-- require("shawn.packer")
require("shawn.ts-context")
require("shawn.lsp")
require("shawn.autocmd")
require("shawn.hydra")
require("shawn.do")
require("shawn.due")
require("shawn.bullets")
require("shawn.nvim-tree")
require("shawn.navic")
require("shawn.tmux")
require("shawn.presence")
require("shawn.buffer_manager")
require("shawn.colorizer")
require("shawn.telescope")
require("shawn.harpoon")
require("shawn.refactor")
require("shawn.copilot")
require("shawn.project")
require("shawn.dap")
require("shawn.git-conflict")
source("~/.config/nvim/settings/markdown-preview.vim")
-- require("shawn.winbar")
-- require("shawn.autotags")
require("shawn.executor_settings")
require("shawn.neoscroll")
require("shawn.session_manager")
source("~/.config/nvim/settings/vim-you-autocorrect.vim")
-- -- require("shawn.jabs")
require("shawn.tokyo-knight")
-- require("shawn.neotest")
require("shawn.vim-test")
-- require("shawn.which-key")
source("~/.config/nvim/settings/bash-lanuage-server.vim")
-- source("~/.config/nvim/settings/NERDtree_settings.vim")
require("shawn.autopairs")
require("shawn.fidget")
source("~/.config/nvim/settings/nerdcommenter_settings.vim")
source("~/.config/nvim/settings/vim-you-autocorrect.vim")
source("~/.config/nvim/settings/vim-closetag.vim")
source("~/.config/nvim/settings/md_paste.vim")
-- require("shawn.terminal")

-- markdown table of contents setting
-- ===================================
vim.g.vmt_auto_update_on_save = 1

vim.cmd([[
" auto enable spellcheck in markdown files
" autocmd BufRead *.md setlocal spell

" trailing white space setting
" =============================
" allow no trailing white space
let b:wstrip_trailing_max = 0

" enable stripping white space when writting to buffer
let g:wstrip_auto = 1

let g:wstrip_highlight = 0

" markdown table of contents setting
" ===================================
" let g:vmt_auto_update_on_save = 1

"disable auto commenting
" autocmd Filetype * setlocal formatoptions-=cro
]])

vim.notify("init.lua sourced")
