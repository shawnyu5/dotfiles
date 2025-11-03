" set rtp+=~/.config/nvim/settings/
" set rtp+=~/.config/nvim/settings/print_debug
" set rtp+=~/.config/nvim/lua/shawn/print/
set laststatus=3
set updatetime=800

" not hide markdown special symbols
set conceallevel=2
set termguicolors

" NOTE: this causes neovim to incorrectly interpret terminal codes when using `fg`
" set nottimeout
set ttimeoutlen=600
set timeoutlen=900

set mouse=a
set noswapfile
set signcolumn=yes

set linebreak

set tabstop=3 softtabstop=3
set winborder=single
set shiftwidth=3
set expandtab

set showtabline=2
set spelloptions+="noplainbuffer"
set spell

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

"wait 0ms after pressing the esc key to see if there are any other key presses
set ttimeoutlen=0
"setting path to current directory to enable searching
set path+=**
set scrolloff=3
