"autocmd FileType python nnoremap <leader>m :!python3 %<CR>
"autocmd FileType cpp nnoremap <leader>m :!make<CR>
"autocmd Filetype sh nnoremap <leader>m :!./%<CR>
"autocmd FileType javascript nnoremap <leader>m :!node %<CR>
"autocmd FileType markdown nnoremap <leader>m :MarkdownPreview<Enter>

lua << EOF
    package.loaded["helpers"] = nil
    vim.api.nvim_set_keymap('n', '<leader>m', ":lua require('helpers').executor()<CR>", { noremap = true, silent = true})
    -- closes all term windows
    vim.api.nvim_set_keymap('n', '<leader>ct', ":lua require('helpers').term_closer()<CR>", { noremap = true, silent = true})

    -- left close
    vim.api.nvim_set_keymap('n', 'ZZ', ":lua require('helpers').leftCloser(true)<CR>", { noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', 'ZQ', ":lua require('helpers').leftCloser()<CR>", { noremap = true, silent = true})
    --map ZZ :call CloseSomething()<CR>
    --map ZQ :call CloseSomething()<CR>
EOF

nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>p "+p

" a function for testing stuff
function! s:test() abort
    let files = ["hello", "world"]
    echo files
    if index(files, "hello") == -1
        echo "noooo"
    else
        echo "ayyy"
    endif
endfunction
" nnoremap <leader>t :call <SID>test()<CR>

" opens a terminal in a new tab
function! Open_term() abort
    exe "tabe | term"
    " exe "terminal"
    exe "norm! i"
endfunction

" Map execution based on file type
function! s:executor() abort
    let current_file_name = expand('%')

    if &ft == 'python'
        call Open_term()
        let command = join(["python3", current_file_name, "\n"])
        call chansend(b:terminal_job_id, command)

    elseif &ft == 'cpp'
        " get all files in current directory
        let files = system('ls')
        " open terminal in vertical split
        call Open_term()

        " if makefile is not in current directory, g++
        if (match(files, "makefile")) == -1
            let command = join(["g++", current_file_name, "&& ./a.out\n"])
            " echo "excuting " . command
            call chansend(b:terminal_job_id, command)
        else
            " else run make
            let command = "make\n"
            " echo "Excuting make"
            call chansend(b:terminal_job_id, command)
        endif
    elseif &ft == 'javascript'
        call Open_term()
        let command = join(["node", current_file_name, "\n"])
        call chansend(b:terminal_job_id, command)

    elseif &ft == 'sh'
        call Open_term()
        let command = join (["./", current_file_name, "\n"], "")
        call chansend(b:terminal_job_id, command)
    elseif &ft == 'markdown'
        exe 'MarkdownPreview'
    elseif &ft == 'html'
        exe '!chrome %'
    elseif &ft == "lua"
        exe "luafile %"
        " call Open_term()
        " let command = join (["luajit ", current_file_name, "\n"], "")
        " call chansend(b:terminal_job_id, command)
    else
        echo 'no mapping created'
    endif
endfunction

" nnoremap <leader>m :call <SID>executor()<CR>

nnoremap <C-g> 2<C-g>
"command to source vimrc
command! Sr :so ~/.config/nvim/init.vim

"map n when searching to always be in center of screen
nnoremap n nzz
nnoremap N Nzz

"esc in terminal mode to go back to normal move
tnoremap <Esc> <C-\><C-n>

nnoremap <silent> <C-f> :MaximizerToggle<CR>

" disable <S-l>
map <S-l> <Nop>
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

" source current file in vim
" autocmd BufWinEnter *.vim nnoremap <leader>m :so %<CR>


"make up down automatically go in between text blocks
nnoremap <silent> k gk
nnoremap <silent> j gj

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
"nnoremap <silent> <F12> :MaximizerToggle<CR>

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
augroup js_maps
    autocmd!
    autocmd FileType javascript inoremap <silent> 'c console.log("BBB");<Esc>?BBB<CR>"_cw
    autocmd FileType javascript inoremap <silent> ''c console.log(BBB);<Esc>?BBB<CR>"_cw
    autocmd Filetype javascript inoremap <silent> ''{ {<CR>BBB<CR>});<CR><Esc>?BBB<CR>"_cw
augroup END

"python file maps
"==============
augroup python_maps
    autocmd!
    autocmd FileType python,lua inoremap 'p print("<++>")<Esc>?<++><CR>"_ca>
    autocmd FileType python,lua inoremap ''p print(<++>)<Esc>?<++><CR>"_ca>
augroup END
