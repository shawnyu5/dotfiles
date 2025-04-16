-- Disable Treesitter async parsing to reduce flickering until this issue is fixed: https://github.com/neovim/neovim/pull/33145
vim.g._ts_force_sync_parsing = true
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"go",
		"bash",
		"lua",
		"python",
		"cpp",
		"java",
		"typescript",
		"rust",
		-- "dockerfile",
		"markdown",
		"markdown_inline",
		"rst",
		"yaml",
		"tsx",
		"c_sharp",
		"terraform",
		"json",
		"toml",
	},
	auto_install = true,
	sync_install = false,
	highlight = {
		enable = true,
		disable = { "text" },

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
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
})
