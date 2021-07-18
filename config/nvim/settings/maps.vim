"leader df for diffthis
nnoremap <silent> <leader>df :diffthis<CR>

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

"leader s to spell check
nnoremap <leader>s :set spell!<Enter>

"print current date
autocmd FileType markdown nnoremap <leader>d i# BBB <Esc>:put =strftime('%a %d %b %Y')<Enter>i<Backspace><Esc>A<Enter><Enter><++><Enter><Esc>/BBB<Enter>"_cw

"leader m to compile current file
"autocmd FileType cpp nnoremap <leader>m :!./compile*.sh<CR>
autocmd FileType cpp nnoremap <leader>m :!make<CR>

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

"leader leader to go to the next <++> place holder
inoremap <silent> '' <Esc>/<++><Enter>"_c4l

"<leader><leader> to go to the next <++> place holder and delete that line
nnoremap <silent> <leader><leader> /<++><Enter>"_c4l

"leader fs to quick fix spelling
nmap <silent> [s <Plug>VimyouautocorrectJump
"nnoremap <leader>fs [sz=1<Enter><Esc>

"f12 to maxmize current screen
nnoremap <silent> <F12> :MaximizerToggle<CR>

autocmd bufreadpre OOP_345_notes.md let g:vmt_auto_update_on_save = 0
autocmd bufreadpre OOP_345_notes.md nnoremap <silent> e :norm! df<Space>VguVyI*<Space>[<Esc>A](#<Esc>pI<BS><Esc>A)<Esc>hhvi(:s/\%V /-/g<CR>

"80>kb^[A)^[hhvi(:s/\%V /-/g^M
"df VguVyI* [^[A](#^[pi<80>kb^[A)^[hhvi(:s/\%V /-/g^M
autocmd FileType markdown nnoremap <leader>t :GenTocGFM<Enter>A<Enter><Esc>?<!<Enter>nkdd

"maps for md files
"=====================
"create link
autocmd Filetype markdown inoremap <silent> '[ [BBB](<++>)<Esc>?BBB<Enter>"_cw
"
"maps for cpp file
"============================

"'c insert cout statement
autocmd Filetype cpp inoremap <silent> 'c cout << "" << endl;<Esc>F"i

";if insert if statement
autocmd FileType cpp inoremap <silent> 'if if (BBB)<Enter>{<Enter><++><Enter>}<Enter><Esc>?BBB<Enter>"_cw

";class insert a class
autocmd FileType cpp inoremap <silent> 'class class BBB<Enter>{<Enter><BS>private:<Enter><++><Enter>public:<Enter><BS><++><Enter>};<Esc>?BBB<Enter>"_cw

"turn a prototype into a function
autocmd FileType cpp nnoremap <silent> <leader>fu _A<BS><Enter>{<Enter>BBB<Enter>}<Esc>?BBB<Enter>cw

"auto indent file upon saving
autocmd FileType cpp autocmd BufWrite mmgg=G`m

"paste text and auto formate
"autocmd FileType cpp nnoremap <leader>p ]p

"maping for bash file
"==============================

";if insert if statement
autocmd FileType sh inoremap <silent> 'if if [[ BBB ]]; then<Enter><++><Enter>fi<Enter><Esc>?BBB<Enter>"_cw

";{ creates { for functions
autocmd Filetype sh,cpp inoremap <silent> '{ {<Enter>BBB<Enter>}<Enter><Esc>?BBB<Enter>"_cw
