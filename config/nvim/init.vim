 "_       _ _               _           
"(_)_ __ (_) |_      __   _(_)_ __ ___  
"| | '_ \| | __|     \ \ / / | '_ ` _ \ 
"| | | | | | |_   _   \ V /| | | | | | |
"|_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|

"placed here for easy access
set relativenumber

"remaping leader to space
let mapleader =" "


source ~/.config/nvim/settings/plugin_manager.vim

source ~/.config/nvim/settings/sets.vim

source ~/.config/nvim/settings/maps.vim

source ~/.config/nvim/settings/NERDtree_settings.vim

source ~/.config/nvim/settings/nerdcommenter_settings.vim

"source ~/.config/nvim/settings/utilsnips_settings.vim

source ~/.config/nvim/settings/ranger_settings.vim

"luafile ~/.config/nvim/sets.lua


if has('nvim-0.5.0')
    "telescope settings
    source ~/.config/nvim/settings/telescope.vim

    "tree sitter settings
    luafile ~/.config/nvim/settings/tree-sitter_config.lua

    "toky night settings
    luafile ~/.config/nvim/settings/tokyo-knight_settings.lua

    "lightline settings to fit tokyo night
    source ~/.config/nvim/settings/markdown-preview.vim

    source ~/.config/nvim/settings/lightLine_settings.vim

elseif has('nvim-0.4.3')
    "load fzf settings
    source ~/.config/nvim/settings/fzf.vim

    "load gruvbox settings
    source ~/.config/nvim/settings/gruv-box_settings.vim
endif

source ~/.config/nvim/settings/coc.vim
source ~/.config/nvim/settings/coc-snippets_settings.vim

source ~/.config/nvim/settings/vim-you-autocorrect.vim

source ~/.config/nvim/settings/md_paste.vim

source ~/.config/nvim/settings/vim-closetag.vim


"native lsp config
"source ~/.config/nvim/settings/lspSaga.vim

"source ~/.config/nvim/settings/native_lsp.vim

"luafile ~/.config/nvim/settings/compe-config.lua

"source ~/.config/nvim/settings/bash-lanuage-server.vim

"set text width
autocmd bufreadpre *.md,*.txt setlocal textwidth=80

" disable indentLine plugin in json and markdown files
let g:indentLine_fileTypeExclude = ['markdown', 'text', 'help']

"auto enable spellcheck in markdown files
au BufRead *.md setlocal spell

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

"autosave a view upon leaving buffer and auto load view upon entering
"augroup AutoSaveFolds
  "autocmd!
  "autocmd BufWinLeave * mkview
  "autocmd BufWinEnter * silent! loadview
"augroup END

"enhanced cpp highlight settings
"==============================
"Highlighting of class scope
"let g:cpp_class_scope_highlight = 1

""Highlighting of member variables
""let g:cpp_member_variable_highlight = 1

""Highlighting of library concepts
"let g:cpp_concepts_highlight = 1

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

