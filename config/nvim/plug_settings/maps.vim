map <S-k> <C-Y>
map <S-J> <C-E>
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
nnoremap Q mmvapgq`m

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

"f12 to maxmize current screen
nnoremap <F12> :MaximizerToggle<CR>

"maps for md files
"=====================
autocmd Filetype markdown inoremap '[ [BBB](<++>)<Esc>?BBB<Enter>"_cw
"
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
