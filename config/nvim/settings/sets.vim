" not hide markdown special symbols
set conceallevel=0
set nottimeout
set ttimeoutlen=600
set timeoutlen=1000

set noswapfile

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
"always show tabs
set showtabline=2
set cursorline
"turning on syntax highlighting
syntax enable
"autocmd BufEnter makefile,Makefile set noexpandtab softtabstop=0

"allow copying to system clipboard
set clipboard+=unnamedplus

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
set wildmode=longest,list,full
"wait 0ms after pressing the esc key to see if there are any other key presses
set ttimeoutlen=0
"setting path to current directory to enable searching
set path+=**
set scrolloff=2
