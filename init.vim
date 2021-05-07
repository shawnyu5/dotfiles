"remaping leader to space
let mapleader =" "

"plugin manager
call plug#begin('~/.config/nvim/plugged') 
"vim autocompletion engin
Plug 'valloric/youcompleteme'
call plug#end() 

"vim inline error messages
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

"may need to uncomment due to youcompleteme engine turning off syntastic check engien
let g:ycm_show_diagnostics_ui = 0
""""""""""""""""""""""""

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

"setting path to current directory to ficliate searching
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
highlight PmenuSel ctermbg=black ctermfg=green 
highlight Pmenu ctermbg=darkblue ctermfg=yellow

"remap substitute command to S
nnoremap S :%s///gc<Left><Left><Left><Left>

"oo to add line after current line but stay in normal mode
nnoremap oo o<Esc>

"OO to add line before current line but stay in normal mode
nnoremap OO O<Esc>
filetype plugin on

"; ; to go to the next <++> place holder
inoremap ;; <Esc>/<++><Enter>"_c4l

"go to the next place holder and delete that line
"inoremap ;, <Esc>/<++><Enter>"_c4l<Esc>dd


"maps for cpp file 
"============================

";{ insert {} 
autocmd Filetype cpp inoremap ;{ {<Enter>BBB<Enter>}<Enter><Enter><++><Esc>/BBB<Enter>cw

";c insert cout statement
autocmd Filetype cpp inoremap ;c cout << "" << endl;<Esc>F"i

";( insert ();
autocmd FileType cpp inoremap ;( (BBB);<Enter><++><Esc>/BBB<Enter>cw

";if insert if statement
autocmd FileType cpp inoremap ;if if (BBB)<Enter>{<Enter><++><Enter>}<Enter><Enter><++><Esc>/BBB<Enter>cw

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
autocmd FileType sh inoremap ;if if [[ BBB ]]; then<Enter><++><Enter><BS>fi<Enter><Enter><++><Esc>/BBB<Enter>cw

"k to comment selected lines
autocmd FileType sh vnoremap k I#<Esc>
