nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fw <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fg <cmd>Telescope git_files<CR>
" nnoremap <leader>fe <cmd>lua require 'telescope'.extensions.file_browser.file_browser({ layout_strategy='vertical', layout_config={width=0.8} })<CR>
nnoremap <leader>fe <cmd>lua require 'telescope'.extensions.file_browser.file_browser(require('telescope.themes').get_dropdown({length = 0.5}))<CR>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').find_files({cwd = "~/.config/nvim/"})<CR>
nnoremap <leader>fr <cmd>Telescope resume<CR>
command! Config :lua require('telescope.builtin').find_files({cwd = "~/.config/nvim/"})

command! Planets :lua require("telescope.builtin").planets({show_pluto = true})
