 "_       _ _               _           
"(_)_ __ (_) |_      __   _(_)_ __ ___  
"| | '_ \| | __|     \ \ / / | '_ ` _ \ 
"| | | | | | |_   _   \ V /| | | | | | |
"|_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|


set nottimeout
set ttimeoutlen=600
set timeoutlen=1000 

set tabstop=4
set shiftwidth=4
set expandtab

"remaping leader to space
let mapleader =" "

source ~/.config/nvim/settings/plugin_manager.vim

source ~/.config/nvim/settings/fzf.vim

source ~/.config/nvim/settings/syntastic.vim

source ~/.config/nvim/settings/coc.vim

source ~/.config/nvim/settings/markdown-preview.vim

source ~/.config/nvim/settings/maps.vim

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


"markdown table of contents setting
"===================================
let g:vmt_auto_update_on_save = 1

autocmd bufreadpre OOP_345_notes.md let g:vmt_auto_update_on_save = 0
autocmd bufreadpre OOP_345_notes.md nnoremap  e :norm! df<Space>VguVyI*<Space>[<Esc>A](#<Esc>pI<BS><Esc>A)<Esc>hhvi(:s/\%V /-/g<CR>

"80>kb^[A)^[hhvi(:s/\%V /-/g^M
"df VguVyI* [^[A](#^[pi<80>kb^[A)^[hhvi(:s/\%V /-/g^M
autocmd FileType markdown nnoremap <leader>t :GenTocGFM<Enter>A<Enter><Esc>?<!<Enter>nkdd

autocmd bufreadpre *.md,*.txt setlocal textwidth=80

"turning on syntax highlighting
syntax enable

"allow copying to system clipboard
set clipboard+=unnamedplus

set number relativenumber
set autoindent
set nohlsearch
set lazyredraw
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
au BufRead *.md,*.txt setlocal spell
