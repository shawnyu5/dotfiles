local ok, tree = pcall(require, "nvim-tree")
if not ok then
	vim.notify("tree not installed...", vim.log.ERROR)
	return
end

tree.setup({
	sort_by = "case_sensitive",
	-- hijack_unnamed_buffer_when_opening = true,
	-- focus_empty_on_setup = true,
   -- open_on_setup = true, -- open tree by default when nvim is open with no args
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
			webdev_colors = false,
			show = {
				file = true,
				folder = true,
				git = false,
			},
			glyphs = {
				default = "",
				folder = {
					arrow_closed = "➜",
					arrow_open = "🠗",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "s",
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

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none", ctermbg = "none" })
