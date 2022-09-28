-- placed here for easy access
vim.opt.relativenumber = true

vim.g.mapleader = " "

--- source a vim file
---@param file string file path to source
local function source(file)
	vim.cmd("source " .. file)
end

require("shawn.plugin_manager")
require("shawn.tree-sitter")
require("shawn.ts-context")
require("shawn.lsp")
-- require("shawn.null-ls")
require("shawn.autocmd")
-- require("shawn.luasnip")
require("shawn.hydra")
require("shawn.lsp_signature")
require("shawn.ultisnips")
require("shawn.do")
require("shawn.nvim-tree")
require("shawn.lightline")
require("shawn.tmux")
-- require("shawn.lualine")
require("shawn.presence")
require("shawn.cmp")
require("shawn.filetype")
source("~/.config/nvim/settings/sets.vim")
require("shawn.colorizer")
require("shawn.telescope")
require("shawn.harpoon")
require("shawn.refactor")
source("~/.config/nvim/settings/maps.vim")
require("shawn.copilot")
require("shawn.project")
require("shawn.dap")
require("shawn.git-conflict")
source("~/.config/nvim/settings/markdown-preview.vim")
require("shawn.winbar")
-- require("shawn.autotags")
require("shawn.executor_settings")
require("shawn.neoscroll")
require("shawn.session_manager")
source("~/.config/nvim/settings/vim-you-autocorrect.vim")
require("shawn.jabs")
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
require("shawn.terminal")

vim.cmd([[
" set text width
" autocmd bufreadpre *.md,*.txt setlocal textwidth=80

" disable indentLine plugin in json and markdown files
" let g:indentLine_fileTypeExclude = ['markdown', 'text', 'help']

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
let g:vmt_auto_update_on_save = 1

"disable auto commenting
" autocmd Filetype * setlocal formatoptions-=cro
]])

vim.notify("init.lua sourced")
