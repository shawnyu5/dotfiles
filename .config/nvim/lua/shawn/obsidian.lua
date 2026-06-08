local utils = require("shawn.utils")
local system_config = utils.get_system_config()
local setup = {
	legacy_commands = false,
	picker = {
		name = "snacks.picker",
	},
	callbacks = {
		enter_note = function()
			local buf = vim.api.nvim_get_current_buf()
			if vim.b[buf].obsidian_maps_set then
				return
			end

			vim.notify("Creating Obsidian notes key maps")
			-- Get the buffer number of the note we just walked into
			local buf = vim.api.nvim_get_current_buf()
			local key_opts = { buffer = buf, remap = false }

			-- key_opts.desc = "Obsidian: Search Titles & Aliases"
			-- vim.keymap.set("n", "<leader>ff", "<cmd>Obsidian quick_switch<CR>", key_opts)

			key_opts.desc = "Obsidian: Live Grep Text Content"
			vim.keymap.set("n", "<leader>fg", "<cmd>Obsidian search<CR>", key_opts)

			key_opts.desc = "Obsidian: Open in editor"
			vim.keymap.set("n", "<leader>m", "<cmd>Obsidian open<CR>", key_opts)

			vim.b[buf].obsidian_maps_set = true
		end,
	},
}
if system_config.system_name == "linux" then
	setup.workspaces = {
		{
			name = "obsidian",
			path = "~/obsidian/",
		},
	}
end

---@module 'obsidian'
---@type obsidian.config
require("obsidian").setup(setup)
