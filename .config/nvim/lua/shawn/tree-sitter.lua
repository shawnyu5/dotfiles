local ok, treesitter = pcall(require, "nvim-treesitter")
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
		"tsx",
		"rust",
		"dockerfile",
	},
	highlight = {
		enable = true,
		-- disable ={ "html" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
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
