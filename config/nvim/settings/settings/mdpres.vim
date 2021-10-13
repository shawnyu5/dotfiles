autocmd BufReadPre *.mdpres set filetype=md
autocmd BufReadPre *.mdpres set filetype=mdpres

autocmd FileType mdpres inoremap '> -> BBB <-<Esc>?BBB<CR>cw
autocmd FileType mdpres inoremap '- -------------------------<CR>
