local M = {}

local keymap = vim.api.nvim_set_keymap

-- use git files if in a git repo, other wise fall back to find_files
function M.project_files()
	local opts = {} -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

keymap("n", "<leader>ff", ":lua require('shawn.telescope').project_files()<CR>", { noremap = true, silent = true })

vim.cmd([[
nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fe <cmd>lua require 'telescope'.extensions.file_browser.file_browser({ layout_strategy='vertical', layout_config={width=0.8} })<CR>
nnoremap <leader>fe <cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').find_files({cwd = "~/.config/nvim/"})<CR>
nnoremap <leader>fr <cmd>Telescope resume<CR>
command! Config :lua require('telescope.builtin').find_files({cwd = "~/.config/nvim/"})

command! Planets :lua require("telescope.builtin").planets({show_pluto = true})
]])

return M
