set rtp+=~/.config/nvim/settings/
set rtp+=~/.config/nvim/settings/print_debug
set rtp+=~/.config/nvim/lua/shawn/print/

" not hide markdown special symbols
set conceallevel=0

autocmd BufEnter *.hbs set ft=html

set nottimeout
set ttimeoutlen=600
set timeoutlen=1000

set noswapfile

set tabstop=3 softtabstop=3
set shiftwidth=3
set expandtab
"always show tabs
set showtabline=2
set cursorline
"turning on syntax highlighting
syntax enable
"autocmd BufEnter makefile,Makefile set noexpandtab softtabstop=0

"allow copying to system clipboard
" set clipboard+=unnamedplus

set number
set autoindent
set nohlsearch
set lazyredraw

"set where the split window appears
set splitbelow splitright
"highlight current line
set cursorline
"disable auto commenting
set formatoptions-=cro

"autocompletion while entering vim commands
set completeopt=menu,menuone,noselect,noinsert
" set wildmode=longest,list,full
" set wildmenu

"wait 0ms after pressing the esc key to see if there are any other key presses
set ttimeoutlen=0
"setting path to current directory to enable searching
set path+=**
set scrolloff=5

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 104})
augroup END
