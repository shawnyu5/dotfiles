"call plug#begins('~/.local/share/nvim/site/autoload')


"call plug#end()

set number relativenumber
syntax enable
set autoindent 
set nohlsearch

"set where the split window appears
set splitbelow splitright

"change scrolling with out moving coursor to use shift up and down arrow keys
map <S-Down> <C-E>
map <S-Up> <C-Y>

"disable auto commenting
set formatoptions-=cro

"autocompletion while entering vim commands
set wildmode=longest,list,full

"turn off auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"wait 0ms after pressing the esc key to see if there are any other key presses
set ttimeoutlen=0

"remap substitute command to S
nnoremap S :%s///gc<Left><Left><Left><Left>

"contrl shift a to open all files in tabs
nnoremap <C-S-A> :tab all<Enter>

