---@module 'obsidian'
---@type obsidian.config
require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "obsidian",
			path = "~/obsidian/",
		},
	},
	picker = {
		name = "snacks.picker",
	},
})
