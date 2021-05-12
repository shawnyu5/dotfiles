"__   _(_)_ __ ___  _ __ ___ 
"\ \ / / | '_ ` _ \| '__/ __|
" \ V /| | | | | | | | | (__ 
"  \_/ |_|_| |_| |_|_|  \___|
"                            

"remaping leader to space
let mapleader =" "

"plugin manager
call plug#begin('~/.config/nvim/plugged') 
"vim autocompletion engin
Plug 'valloric/youcompleteme'
"status bar
Plug 'itchyny/lightline.vim'
"auto paste images into markdown
Plug 'ferrine/md-img-paste.vim'
call plug#end() 

"Synastics settings
execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"always populate the error message list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1

"check error upon opening a file in vim. set to false
let g:syntastic_check_on_open = 0

"check when file is saved. set to true
let g:syntastic_check_on_wq = 1 

"sets the height of the error window
let g:syntastic_loc_list_height = 7
let g:syntastic_mode_map = { "mode": "passive" }

"prevent vim :mksessions from saving syntastic error window as a blank window 
set sessionoptions-=blank

"display error message pane only in normal mode
nnoremap e<leader> :w<Enter>:SyntasticCheck<Enter>

"close error message pane, only in normal mode
nnoremap c<leader> :lclose<Enter>

"ignoring multiple level headers in a single document warning in md
let g:syntastic_quiet_messages = { 'regex': 'MD025\|MD013' }

"enable error checking in documents running youCompleteMe engin
let g:ycm_show_diagnostics_ui = 0
"=================================

"markdown image paste settings
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
"default intext name and directory where images are saved
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'image'
"============================

"turning on syntax highlighting
syntax enable			

set number relativenumber
set autoindent 
set nohlsearch

"set where the split window appears
set splitbelow splitright	

"disable auto commenting
set formatoptions-=cro		

"autocompletion while entering vim commands
set wildmode=longest,list,full	

"wait 0ms after pressing the esc key to see if there are any other key presses
set ttimeoutlen=0		

"setting path to current directory to enable searching
set path+=** 			

"shift up and down arrow keys to scroll without moving cursor
map <S-Down> <C-E>	
map <S-Up> <C-Y>

"contrl shift A to open all files in tabs
map <C-S-A> :tab all<Enter>

"make up down automatically go in between text blocks
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap k gk
nnoremap j gj

"turn off auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o	

"change autocompletion menu color
highlight PmenuSel ctermbg=red	ctermfg=green 
highlight Pmenu ctermbg=darkblue ctermfg=yellow

"shift S to substitute
nnoremap S :%s///gc<Left><Left><Left><Left>

"oo to add line after current line but stay in normal mode
nnoremap oo o<Esc>

"OO to add line before current line but stay in normal mode
nnoremap OO O<Esc>
filetype plugin on

"; ; to go to the next <++> place holder
inoremap ;; <Esc>/<++><Enter>"_c4l

"; ' to go to the next <++> place holder and delete that line
inoremap ;' <Esc>/<++><Enter>ddi

"m leader to run make in current file
nnoremap m<leader> :make<Enter>

"maps for cpp file 
"============================

"autofill {
autocmd Filetype cpp inoremap { {}<Left>

"autofill (
autocmd FileType cpp inoremap ( ()<Left>

";c insert cout statement
autocmd Filetype cpp inoremap ;c cout << "" << endl;<Esc>F"i

";if insert if statement
autocmd FileType cpp inoremap ;if if (BBB)<Enter>{<Enter><++><Enter>}<Enter><++><Esc>/BBB<Enter>cw

";class insert a class
autocmd FileType cpp inoremap ;class class BBB<Enter>{<Enter><BS>private:<Enter><++><Enter>public:<Enter><BS><++><Enter>};<Esc>/BBB<Enter>cw

"k to comment selected lines
autocmd FileType cpp vnoremap k I//<Esc>

"maps for .h file
"=============================

";class insert a class
autocmd FileType cpp inoremap ;class class BBB<Enter>{<Enter><BS>private:<Enter><++><Enter>public:<Enter><BS><++><Enter>};<Esc>/BBB<Enter>cw

"k to comment selected lines
autocmd FileType h vnoremap k I//<Esc>

"maping for bash file
"==============================

";if insert if statement
autocmd FileType sh inoremap ;if if [[BBB]]; then<Enter><++><Enter>fi<Enter><++><Esc>/BBB<Enter>cw

"k to comment selected lines
autocmd FileType sh vnoremap k I#<Esc>

"auto fill for {
autocmd Filetype sh inoremap { {}<Left>

