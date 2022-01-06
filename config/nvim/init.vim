 "_       _ _               _           
"
"| | '_ \| | __|     \ \ / / | '_ ` _ \ 
"| | | | | | |_   _   \ V /| | | | | | |
"|_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|

" placed here for easy access
set relativenumber

" remaping leader to space
let mapleader =" "

luafile ~/.config/nvim/plugin_manager.lua

source ~/.config/nvim/settings/sets.vim

source ~/.config/nvim/settings/maps.vim

" source ~/.config/nvim/settings/NERDtree_settings.vim

" luafile ~/.config/nvim/settings/autopairs_settings.lua

" source ~/.config/nvim/settings/nerdcommenter_settings.vim

" source ~/.config/nvim/settings/utilsnips_settings.vim

" source ~/.config/nvim/settings/executor_settings.lua

" source ~/.config/nvim/settings/ranger_settings.vim

" luafile ~/.config/nvim/lua/shawn/print_debug/init.lua

" luafile ~/.config/nvim/settings/harpoon_settings.lua

"telescope settings
" source ~/.config/nvim/settings/telescope.vim

"tree sitter settings
" luafile ~/.config/nvim/settings/tree-sitter_config.lua

"toky night settings
" luafile ~/.config/nvim/settings/tokyo-knight_settings.lua

"lightline settings to fit tokyo night
" source ~/.config/nvim/settings/lightLine_settings.vim

" source ~/.config/nvim/settings/markdown-preview.vim

"native lsp config
" luafile ~/.config/nvim/settings/native_lsp.lua
" luafile ~/.config/nvim/settings/cmp_config.lua
source ~/.config/nvim/settings/bash-lanuage-server.vim
" luafile ~/.config/nvim/settings/lsp_signature.lua
" luafile ~/.config/nvim/settings/null-ls_settings.lua

" source ~/.config/nvim/settings/coc.vim
" source ~/.config/nvim/settings/coc-snippets_settings.vim

" luafile ~/.config/nvim/settings/luasnippets_settings.lua

" source ~/.config/nvim/settings/vim-you-autocorrect.vim

source ~/.config/nvim/settings/md_paste.vim

" source ~/.config/nvim/settings/vim-closetag.vim

"set text width
autocmd bufreadpre *.md,*.txt setlocal textwidth=80

" disable indentLine plugin in json and markdown files
" let g:indentLine_fileTypeExclude = ['markdown', 'text', 'help']

"auto enable spellcheck in markdown files
autocmd BufRead *.md setlocal spell

" autocmd BufRead *.hbs echo "hello"

" aug i3config_ft_detection
  " au!
  " au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
" aug end

"autosave a view upon leaving buffer and auto load view upon entering
"augroup AutoSaveFolds
  " "autocmd!
  " "autocmd BufWinLeave * mkview
  " "autocmd BufWinEnter * silent! loadview
"augroup END

"trailing white space setting
"=============================
"allow no trailing white space
let b:wstrip_trailing_max = 0

"enable stripping white space when writting to buffer
let g:wstrip_auto = 1

let g:wstrip_highlight = 0

"markdown table of contents setting
"===================================
let g:vmt_auto_update_on_save = 1
