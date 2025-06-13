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

--- Perform the default action in telescope, and set the search register to the `/` register
---@param prompt_bufnr number: The prompt buffer number
local function set_search_register(prompt_bufnr)
	local content = require("telescope.actions.state").get_current_line()
	local actions = require("telescope.actions")
	vim.fn.setreg("/", content)
	actions.select_default(prompt_bufnr)
end

local telescope_builtin = require("telescope.builtin")

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>fd", function()
	telescope_builtin.diagnostics()
end, opts)
vim.keymap.set("n", "<leader>ff", function()
	telescope_builtin.find_files({
		hidden = true,
	})
end, { desc = "fuzzy find all files in pwd, including hidden files" })
vim.keymap.set("n", "<leader>fb", function()
	telescope_builtin.buffers()
	-- require("telescope").extensions.frecency.frecency({})
end, { desc = "fuzzy search all buffers" })
vim.keymap.set("n", "<leader>fw", function()
	telescope_builtin.live_grep({})
end, { desc = "fuzzy search words" })
vim.keymap.set("n", "<leader>fc", function()
	telescope_builtin.find_files({ cwd = "~/.config/nvim" })
end, { desc = "fuzzy search over neovim config" })
vim.keymap.set("n", "<leader>fr", telescope_builtin.resume, { desc = "resume last telescope search" })
vim.keymap.set("n", "<leader>fh", function()
	local ft = vim.bo.filetype
	if ft == "markdown" then
		vim.cmd("Telescope heading")
	else
		telescope_builtin.help_tags()
	end
end, { desc = "fuzzy search vim help tags" })
vim.keymap.set({ "n", "v" }, "<leader><leader>fw", function()
	telescope_builtin.grep_string()
end, { desc = "live grep for word under cursor" })
vim.keymap.set("n", "<leader>gb", function()
	telescope_builtin.git_branches({
		show_remote_tracking_branches = false,
	})
end, { desc = "fuzzy search git branches" })
vim.keymap.set(
	"n",
	"<leader>f/",
	telescope_builtin.current_buffer_fuzzy_find,
	{ desc = "Fuzzy find in current buffer" }
)

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
			theme = "ivy",
			additional_args = { "--hidden" },
		},
		grep_string = {
			theme = "ivy",
			additional_args = { "--hidden" },
		},
		current_buffer_fuzzy_find = {
			theme = "ivy",
			mappings = {
				i = {
					["<CR>"] = set_search_register,
				},
			},
		},
		git_branches = {},
	},
	defaults = {
		file_ignore_patterns = { ".git/", "^vendor/" },
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
		-- frecency = {
		--    default_workspace = "CWD",
		--    -- Do not show current buffer in candidates
		--    hide_current_buffer = true,
		-- },
	},
})

telescope.load_extension("ui-select")
telescope.load_extension("fzf")
-- telescope.load_extension("frecency")
telescope.load_extension("heading")

return M
