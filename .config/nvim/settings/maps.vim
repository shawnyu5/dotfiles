nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>p "+p

nnoremap <S-Left> <CMD>tabm -1<CR>
nnoremap <S-right> <CMD>tabm +1<CR>

command! ImagePaste :call mdip#MarkdownClipboardImage()<CR>

nnoremap <C-g> 2<C-g>
"command to source vimrc
command! Sr :so ~/.config/nvim/init.lua

"map n when searching to always be in center of screen
nnoremap n nzz
nnoremap N Nzz

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"esc in terminal mode to go back to normal move
tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <C-f> :MaximizerToggle<CR>

" paste in visual mode without copying to clipboard
xnoremap p "_dP

" disable L and H, could be overrode by other configs later
map <S-l> <Nop>
map <S-h> <Nop>

"leader df for diffthis
" nnoremap <leader>df :diffthis<CR>
"leader do for diffoff
" nnoremap <silent> <leader>do :diffoff<CR>

"scrolling without moving the cursor
" map <S-k> <C-Y>
" map <S-J> <C-E>
" map <S-down> <C-E>
" map <S-up> <C-Y>

"control prefix for split management
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l

"Y to copy till end of line
nnoremap Y y$

"control shift for split resizing
nnoremap <silent> <C-Right> :vertical res +2<CR>
nnoremap <silent> <C-Left> :vertical res -2<CR>
nnoremap <silent> <C-up> :res +2<CR>
nnoremap <silent> <C-Down> :res -2<CR>

"leader s to spell check
"nnoremap <leader>s :set spell!<CR>


"make up down automatically go in between text blocks
nnoremap <silent> k gk
nnoremap <silent> j gj

"turn off auto commenting
autocmd FileType * set formatoptions-=cro


"change autocompletion menu color
highlight PmenuSel ctermbg=red	ctermfg=green
highlight Pmenu ctermbg=darkblue ctermfg=yellow

"shift S to substitute
nnoremap S :%s///gc<Left><Left><Left><Left>

filetype plugin on

"<leader><leader> to go to the next <++> place holder and delete that line
nnoremap <silent> <leader><leader><leader> /<++><CR>"_c4l

"leader fs to quick fix spelling
nmap <silent> [s <Plug>VimyouautocorrectJump

autocmd FileType markdown nnoremap <buffer> <leader>t :GenTocGFM<CR>A<CR><Esc>?<!<CR>nkdd
