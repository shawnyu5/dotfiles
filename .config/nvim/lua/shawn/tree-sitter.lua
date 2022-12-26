local ok, _ = pcall(require, "nvim-treesitter")
if not ok then
	print("treesitter not installed...")
	return
end
-- :TSInstall javascript bash lua python cpp vim
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"go",
		"bash",
		"lua",
		"python",
		"cpp",
		"vim",
		"java",
		"typescript",
		"rust",
		"dockerfile",
		"markdown",
		"markdown_inline",
		"yaml",
		"tsx",
	},

	highlight = {
		enable = true,
		-- disable ={ "html" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			-- init_selection = "gnn",
			node_incremental = "<CR>",
			-- scope_incremental = "grc",
			node_decremental = "<BS>",
		},
	},
})
