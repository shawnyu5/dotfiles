let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim/settings
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 ~/.config/nvim/UltiSnips/all.snippets
badd +0 test.html
argglobal
%argdel
edit test.html
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 8 + 14) / 29)
exe '2resize ' . ((&lines * 17 + 14) / 29)
exe 'vert 2resize ' . ((&columns * 65 + 65) / 131)
exe '3resize ' . ((&lines * 17 + 14) / 29)
exe 'vert 3resize ' . ((&columns * 65 + 65) / 131)
argglobal
if bufexists("~/.config/nvim/plugged/ultisnips/doc/UltiSnips.txt") | buffer ~/.config/nvim/plugged/ultisnips/doc/UltiSnips.txt | else | edit ~/.config/nvim/plugged/ultisnips/doc/UltiSnips.txt | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/plugged/ultisnips/doc/UltiSnips.txt
endif
balt ~/.config/nvim/UltiSnips/all.snippets
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
silent! normal! zE
let &fdl = &fdl
let s:l = 671 - ((2 * winheight(0) + 4) / 8)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 671
normal! 0
wincmd w
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists("~/.config/nvim/UltiSnips/all.snippets") | buffer ~/.config/nvim/UltiSnips/all.snippets | else | edit ~/.config/nvim/UltiSnips/all.snippets | endif
if &buftype ==# 'terminal'
  silent file ~/.config/nvim/UltiSnips/all.snippets
endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 2 - ((1 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 010|
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 8 + 14) / 29)
exe '2resize ' . ((&lines * 17 + 14) / 29)
exe 'vert 2resize ' . ((&columns * 65 + 65) / 131)
exe '3resize ' . ((&lines * 17 + 14) / 29)
exe 'vert 3resize ' . ((&columns * 65 + 65) / 131)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
