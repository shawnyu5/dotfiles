autocmd FileType python nnoremap <leader>m :!python3 %<CR>

"command to source vimrc
command! Sr :so ~/.config/nvim/init.vim

"map n when searching to always be in center of screen
nnoremap n nzz
nnoremap N Nzz

"esc in terminal mode to go back to normal move
tnoremap <Esc> <C-\><C-n>

"leader df for diffthis
nnoremap <leader>df :diffthis<CR>
"leader do for diffoff
nnoremap <silent> <leader>do :diffoff<CR>

"scrolling without moving the cursor
map <S-k> <C-Y>
map <S-J> <C-E>
map <S-down> <C-E>
map <S-up> <C-Y>

"control prefix for split management
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"Y to copy till end of line
nnoremap Y y$

"control shift for split resizing
nnoremap <silent> <C-Right> :vertical res +2<CR>
nnoremap <silent> <C-Left> :vertical res -2<CR>
nnoremap <silent> <C-up> :res +2<CR>
nnoremap <silent> <C-Down> :res -2<CR>

"leader s to spell check
"nnoremap <leader>s :set spell!<CR>

"print current date
autocmd FileType markdown nnoremap <leader>da i# BBB <Esc>:put =strftime('%a %d %b %Y')<CR>i<Backspace><Esc>A<CR><CR><++><CR><Esc>/BBB<CR>"_cw

autocmd BufWinEnter 2021.md nnoremap <leader>da O<Esc>O# BBB<Esc>:put =strftime('%a %d %b %Y')<CR>i<Backspace><Esc>A<CR><CR>Dear journal,<CR><CR><++><Esc>/BBB<CR>"_cw

"leader m to compile current file
"autocmd FileType cpp nnoremap <leader>m :!./compile*.sh<CR>
autocmd FileType cpp nnoremap <leader>m :!make<CR>

" source current file in init.vim
autocmd BufWinEnter init.vim nnoremap <leader>m :so %<CR>


"make up down automatically go in between text blocks
nnoremap k gk
nnoremap j gj

"Q to reformate text
nnoremap Q mmvapgq`m

"turn off auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"change autocompletion menu color
highlight PmenuSel ctermbg=red	ctermfg=green
highlight Pmenu ctermbg=darkblue ctermfg=yellow

"shift S to substitute
nnoremap S :%s///gc<Left><Left><Left><Left>

"oo to add line after current line but stay in normal mode
"nnoremap oo o<Esc>

"OO to add line before current line but stay in normal mode
"nnoremap OO O<Esc>

filetype plugin on

"<leader><leader> to go to the next <++> place holder and delete that line
nnoremap <silent> <leader><leader> /<++><CR>"_c4l

"leader fs to quick fix spelling
nmap <silent> [s <Plug>VimyouautocorrectJump
"nnoremap <leader>fs [sz=1<Enter><Esc>

"f12 to maxmize current screen
nnoremap <silent> <F12> :MaximizerToggle<CR>

autocmd bufreadpre OOP_345_notes.md let g:vmt_auto_update_on_save = 0
autocmd bufreadpre OOP_345_notes.md nnoremap <silent> e :norm! df<Space>VguVyI*<Space>[<Esc>A](#<Esc>pI<BS><Esc>A)<Esc>hhvi(:s/\%V /-/g<CR>

"80>kb^[A)^[hhvi(:s/\%V /-/g^M
"df VguVyI* [^[A](#^[pi<80>kb^[A)^[hhvi(:s/\%V /-/g^M
autocmd FileType markdown nnoremap <leader>t :GenTocGFM<CR>A<CR><Esc>?<!<CR>nkdd

"maps for md files
"=====================
"create link
autocmd Filetype markdown inoremap <silent> '[ [BBB](<++>)<Esc>?BBB<CR>"_cw
"
"maps for cpp file
"============================

augroup cpp_maps
    autocmd!
    "'c insert cout statement
    autocmd Filetype cpp inoremap <silent> 'c cout << "" << '\n';<Esc>F"i

    ";if insert if statement
    autocmd FileType cpp inoremap <silent> 'if if (BBB)<CR>{<CR><++><CR>}<CR><Esc>?BBB<CR>"_cw

    ";class insert a class
    "autocmd FileType cpp inoremap <silent> 'class class BBB<CR>{<CR><BS>private:<CR><++><CR>public:<CR><BS><++><CR>};<Esc>?BBB<CR>"_cw

    "turn a prototype into a function
    autocmd FileType cpp nnoremap <silent> <leader>fu _A<BS><CR>{<CR>BBB<CR>}<Esc>?BBB<CR>"_cw

    "auto indent file upon saving
    "autocmd FileType cpp autocmd BufWrite mmgg=G`m

    "paste text and auto formate
    "autocmd FileType cpp nnoremap <leader>p ]p
augroup END

"general programming lanuage maps
"==========================
"'{ creates { for functions
autocmd Filetype sh,cpp,javascript,python inoremap <silent> '{ {<CR>BBB<CR>}<CR><Esc>?BBB<CR>"_cw

"bash file maps
"==============================

augroup bash_maps
    autocmd!
    "'if insert if statement
    autocmd FileType sh inoremap <silent> 'if if [[ BBB ]]; then<CR><++><CR>fi<CR><Esc>?BBB<CR>"_cw

    "'e insert echo statement
    autocmd FileType sh inoremap <silent> 'e echo "BBB"<Esc>?BBB<CR>"_cw

    "leader m to excute current file
    autocmd Filetype sh nnoremap <leader>m :!./%<CR>
augroup END

"md\html maps
"============================
"'ul insert <ul></ul>
augroup html_maps
    autocmd!
    autocmd Filetype html,markdown inoremap 'ul <ul>BBB</ul><Esc>?BBB<CR>"_cw

    "'li insert <li></li>
    autocmd Filetype html,markdown inoremap 'li <li>BBB</li><Esc>?BBB<CR>"_cw

    autocmd FileType markdown inoremap '> -> # BBB<-<CR><CR><++><Esc>?BBB<CR>"_cw
    autocmd FileType markdown inoremap '- -------------------------<CR><CR>-> # BBB<-<CR><CR><++><Esc>?BBB<CR>"_cw
augroup END

"js file maps
"===========================
"leader m to run current code in node
autocmd FileType javascript nnoremap <leader>m :!node %<CR>

"python file maps
"==============
augroup python_maps
    autocmd!
    autocmd FileType python inoremap 'p print("<++>")<Esc>?<++><CR>"_ca>
augroup END
