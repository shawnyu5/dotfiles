require("nvim-tree").setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	renderer = {
		group_empty = true,
		icons = {
			show = {
				file = true,
				folder = true,
				git = false,
			},
			glyphs = {
				default = "",
				folder = {
					arrow_closed = "",
					arrow_open = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
		},
	},
	filters = {
		dotfiles = true,
	},
})

local map = vim.keymap.set

map("n", "<leader>nn", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("n", "<leader>nf", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
