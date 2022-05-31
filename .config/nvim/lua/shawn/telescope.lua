local ok, telescope = pcall(require, "telescope")
if not ok then
	print("telescope not installed...")
	return
end
local M = {}

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- use git files if in a git repo, other wise fall back to find_files
function M.project_files()
	local opts = {} -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

-- keymap("n", "<leader>ff", ":lua require('shawn.telescope').project_files()<CR>", { noremap = true, silent = true })
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fe", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", opts)
keymap("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fc", "<cmd>lua require('telescope.builtin').find_files({cwd = '~/.config/nvim/'})<CR>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope resume<CR>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts)

vim.cmd([[
command! Config :lua require('telescope.builtin').find_files({cwd = "~/.config/nvim/"})
command! Planets :lua require("telescope.builtin").planets({show_pluto = true})
]])

require("telescope").setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")

return M
