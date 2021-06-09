 "_       _ _               _           
"(_)_ __ (_) |_      __   _(_)_ __ ___  
"| | '_ \| | __|     \ \ / / | '_ ` _ \ 
"| | | | | | |_   _   \ V /| | | | | | |
"|_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|
                                       
set nottimeout
set ttimeoutlen=500
set timeoutlen=900 

"remaping leader to space
let mapleader =" "

"plugin manager
call plug#begin('~/.config/nvim/plugged') 

"status bar
Plug 'itchyny/lightline.vim'

"auto paste images into markdown
Plug 'ferrine/md-img-paste.vim'

"COC auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"center current text
"Plug 'junegunn/goyo.vim'

"brower based markdown preview
Plug 'iamcco/markdown-preview.nvim'

"error checking
Plug 'vim-syntastic/syntastic'

"table of contents
Plug 'mzlogin/vim-markdown-toc'

"smooth scrolling
Plug 'psliwka/vim-smoothie'

"opening links in vim
Plug 'chmp/mdnav'

"rmove trailing white spaces
Plug 'tweekmonster/wstrip.vim'

"vim color scheme
"Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'

"block commenting
Plug 'preservim/nerdcommenter'

"vim maxmizer
Plug 'szw/vim-maximizer'

"enhanced cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

"matchit
Plug 'adelarsq/vim-matchit'

"vim in the browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

"enhanced cpp highlight settings
"==============================
"Highlighting of class scope
let g:cpp_class_scope_highlight = 1

"Highlighting of member variables
"let g:cpp_member_variable_highlight = 1

"Highlighting of library concepts
let g:cpp_concepts_highlight = 1

"gruvbox settings
"=====================
autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

"improved error messages
let g:gruvbox_improved_warnings = 1

set background=dark    " Setting dark mode

"trailing white space setting
"=============================
"allow no trailing white space
let b:wstrip_trailing_max = 0

"enable stripping white space when writting to buffer
let g:wstrip_auto = 1  

"Synastics settings
"===========================
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
nnoremap <leader>e :w<Enter>:SyntasticCheck<Enter>

"close error message pane, only in normal mode
nnoremap <leader>c :lclose<Enter>

"ignoring multiple level headers in a single document warning in md
let g:syntastic_quiet_messages = { 'regex': 'MD025\|MD029\|MD010\|MD007' }

"enable error checking in documents running youCompleteMe engin
let g:ycm_show_diagnostics_ui = 0
"=================================

"markdown image paste settings
"====================================
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR><esc>f)i<Space>=500x<Esc>F5

let cwd = $PWD . '/img'
let g:mdip_imgdir_absolute = cwd
let g:mdip_imgdir_intext = cwd

"default intext name and directory where images are saved
let g:mdip_imgdir_absolute = 'img'
let g:mdip_imgdir_intext = 'img'
let g:mdip_imgname = 'image'

"COC settings
"====================
set hidden
set cmdheight=2
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"go to function definition
nmap <leader>gd <Plug>(coc-definition)
"go to function reference
nmap  <leader>gr <Plug>(coc-references)
"======================

"markdown preview settings
"==============================
" set to 1, nvim will open the preview window after entering the markdown buffer
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
let g:mkdp_refresh_slow = 1

" specify browser to open preview page
let g:mkdp_browser = 'chrome'

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = '/home/shawn/scripts/.gitHub_markdown_css.css'

"MarkdownPreview mapped to leader m
autocmd FileType markdown nnoremap <leader>m :MarkdownPreview<Enter>
"===========================

"markdown table of contents setting
"===================================
let g:vmt_auto_update_on_save = 1

autocmd bufreadpre OOP_345_notes.md let g:vmt_auto_update_on_save = 0

autocmd FileType markdown nnoremap <leader>t :GenTocGFM<Enter>A<Enter><Esc>?<!<Enter>nkdd

autocmd bufreadpre *.md setlocal textwidth=80

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

set scrolloff=2

"change tab width
"set tabstop=4 softtabstop=4

"auto enable spellcheck in markdown files
au BufRead *.md setlocal spell

" note trailing space at end of next line
"autocmd FileType markdown set showbreak=>\ \ \

"autoremove trailing white space everytime vim is saved
"autocmd BufWritePre * %s/\s\+$//e

"shift up and down arrow keys to scroll without moving cursor
map <S-j> <C-E>
map <S-k> <C-Y>
map <S-down> <C-E>
map <S-up> <C-Y>

"leader s to spell check
nnoremap <leader>s :set spell!<Enter>

"print current date
autocmd FileType markdown nnoremap <leader>d i# BBB <Esc>:put =strftime('%a %d %b %Y')<Enter>i<Backspace><Esc>A<Enter><Enter><++><Enter><Esc>/BBB<Enter>"_cw

"leader m to compile current file
"autocmd FileType cpp nnoremap <leader>m :!make<CR>
autocmd FileType cpp nnoremap <leader>m :!./compile*.sh<CR>

"make up down automatically go in between text blocks
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap k gk
nnoremap j gj

"Q to reformate text
nnoremap Q gqq

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

"'' to go to the next <++> place holder
inoremap '' <Esc>/<++><Enter>"_c4l

"<leader><leader> to go to the next <++> place holder and delete that line
nnoremap <leader><leader> /<++><Enter>ca<

"leader fs to quick fix spelling
nnoremap <leader>fs [sz=1<Enter><Esc>

"maps for md files
"=====================
inoremap '[ [BBB](<++>)<Esc>?BBB<Enter>"_cw
"maps for cpp file
"============================

"autofill {
"autocmd Filetype cpp inoremap { {}<Left>

"autofill (
"autocmd FileType cpp inoremap ( ()<Left>

"'c insert cout statement
autocmd Filetype cpp inoremap 'c cout << "" << endl;<Esc>F"i

";if insert if statement
autocmd FileType cpp inoremap 'if if (BBB)<Enter>{<Enter><++><Enter>}<Enter><Esc>/BBB<Enter>"_cw

";class insert a class
autocmd FileType cpp inoremap 'class class BBB<Enter>{<Enter><BS>private:<Enter><++><Enter>public:<Enter><BS><++><Enter>};<Esc>/BBB<Enter>"_cw

"maping for bash file
"==============================

";if insert if statement
autocmd FileType sh inoremap 'if if [[ BBB ]]; then<Enter><++><Enter>fi<Enter><Esc>/BBB<Enter>"_cw

"auto fill for {
"autocmd Filetype sh inoremap { {}<Left>

";{ creates { for functions
autocmd Filetype sh,cpp inoremap '{ {<Enter>BBB<Enter>}<Enter><Esc>/BBB<Enter>"_cw
