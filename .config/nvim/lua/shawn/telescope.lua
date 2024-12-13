local telescope = require("telescope")
local M = {}

-- use git files if in a git repo, other wise fall back to find_files
function M.project_files()
	local opts = {} -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

local keymap = vim.keymap.set
-- vim.keymap.set('n', 'lhs', function() print("real lua function") end)

local telescope_builtin = require("telescope.builtin")

local opts = { noremap = true, silent = true }
keymap("n", "<leader>fd", function()
	telescope_builtin.diagnostics()
end, opts)
keymap("n", "<leader>ff", function()
	telescope_builtin.find_files({
		hidden = true,
	})
end, { desc = "fuzzy find all files in pwd, including hidden files" })
keymap("n", "<leader>fb", function()
	telescope_builtin.buffers()
	-- require("telescope").extensions.frecency.frecency({})
end, { desc = "fuzzy search all buffers" })
keymap("n", "<leader>fw", function()
	telescope_builtin.live_grep({ layout_strategy = "vertical" })
end, { desc = "fuzzy search words" })
keymap("n", "<leader>fc", function()
	telescope_builtin.find_files({ cwd = "~/.config/nvim" })
end, { desc = "fuzzy search over neovim config" })
keymap("n", "<leader>fr", telescope_builtin.resume, { desc = "resume last telescope search" })
keymap("n", "<leader>fh", function()
	local ft = vim.bo.filetype
	if ft == "markdown" then
		vim.cmd("Telescope heading")
	else
		telescope_builtin.help_tags()
	end
end, { desc = "fuzzy search vim help tags" })
keymap({ "n", "v" }, "<leader><leader>fw", function()
	telescope_builtin.grep_string({ layout_strategy = "vertical" })
end, { desc = "live grep for word under cursor" })
keymap("n", "<leader>gb", function()
	telescope_builtin.git_branches({
		show_remote_tracking_branches = false,
	})
end, { desc = "fuzzy search git branches" })

vim.cmd([[
   command! Config :lua require('telescope.builtin').find_files({cwd = "~/.config/nvim/"})
   command! Planets :lua require("telescope.builtin").planets({show_pluto = true})
]])

require("telescope").setup({
	pickers = {
		find_files = {
			follow = true,
		},
		lsp_references = {
			theme = "ivy",
			initial_mode = "normal",
		},
		live_grep = {
			additional_args = { "--hidden" },
		},
		git_branches = {
			initial_mode = "normal",
		},
	},
	defaults = {
		file_ignore_patterns = { ".git/" },
		path_display = { truncate = 3 },
		layout_config = {
			vertical = {
				preview_cutoff = 20,
			},
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		heading = {
			treesitter = true,
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		frecency = {
			default_workspace = "CWD",
			-- Do not show current buffer in candidates
			hide_current_buffer = true,
		},
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("fzf")
telescope.load_extension("frecency")
telescope.load_extension("heading")

return M
