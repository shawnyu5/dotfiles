"call plug#begins('~/.local/share/nvim/site/autoload')


"call plug#end()

set number relativenumber
syntax enable
set autoindent 

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


