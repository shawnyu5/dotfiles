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
