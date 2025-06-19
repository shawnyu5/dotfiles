local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.notify_once("lazy not installed, installing...", vim.log.levels.WARN)
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
	vim.notify("lazy not installed...", vim.log.levels.WARN)
	return
end
local utils = require("shawn.utils")

local pluginSpec = {
	{ "folke/lazy.nvim" },
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},

	{ "tpope/vim-fugitive" },
	{
		"mfussenegger/nvim-ansible",
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	{ "xuhdev/vim-latex-live-preview", ft = { "tex", "plaintex" } },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			require("shawn.ufo")
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			signs = false, -- show icons in the signs column
			sign_priority = 8, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = true, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		config = function()
			require("shawn.tree-sitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("shawn.ts-context")
		end,
	},
	{ "anuvyklack/hydra.nvim" },
	{ "norcalli/nvim-colorizer.lua" },
	{
		"sindrets/diffview.nvim",
	},
	-- {
	--    "akinsho/git-conflict.nvim",
	--    version = "v2.1.0",
	--    config = function()
	--       require("shawn.git-conflict")
	--    end,
	-- },
	{
		"folke/tokyonight.nvim",
		branch = "main",
	},
	{ "echasnovski/mini.indentscope" },
	{
		"Bekaboo/dropbar.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local opts = {
				icons = {
					enable = true,
					ui = {
						bar = {
							separator = "➜ ",
							extends = "…",
						},
					},

					kinds = {
						symbols = {
							Array = "📚",
							BlockMappingPair = "🔗",
							Boolean = "✔️",
							BreakStatement = "⛔",
							Call = "📞",
							CaseStatement = "🗂️",
							Class = "🏫",
							Color = "🎨",
							Constant = "🔒",
							Constructor = "🏗️",
							ContinueStatement = "➡️",
							Copilot = "🤖",
							Declaration = "📜",
							Delete = "🗑️",
							DoStatement = "🔄",
							Element = "🔧",
							Enum = "🔢",
							EnumMember = "🔠",
							Event = "🎉",
							Field = "🌾",
							File = "📄",
							Folder = "📁",
							ForStatement = "🔁",
							Function = "🔧",
							GotoStatement = "🚀",
							Identifier = "🆔",
							IfStatement = "❓",
							Interface = "🖧",
							Keyword = "🔑",
							List = "📋",
							Log = "📝",
							Lsp = "🛠️",
							Macro = "🔍",
							MarkdownH1 = "🅰️",
							MarkdownH2 = "🅱️",
							MarkdownH3 = "🅾️",
							MarkdownH4 = "🔤",
							MarkdownH5 = "🔡",
							MarkdownH6 = "🔠",
							Method = "📖",
							Module = "📦",
							Namespace = "🌐",
							Null = "🚫",
							Number = "🔢",
							Object = "🛠️",
							Operator = "➕",
							Package = "📦",
							Pair = "🤝",
							Property = "🏠",
							Reference = "🔗",
							Regex = "🔍",
							Repeat = "🔁",
							Return = "↩️",
							RuleSet = "📜",
							Scope = "🔭",
							Section = "📚",
							Snippet = "✂️",
							Specifier = "📌",
							Statement = "🗣️",
							String = "🧵",
							Struct = "🏗️",
							SwitchStatement = "🔀",
							Table = "📊",
							Terminal = "💻",
							Text = "📝",
							Type = "🔤",
							TypeParameter = "🔣",
							Unit = "📏",
							Value = "💎",
							Variable = "🔧",
							WhileStatement = "🔄",
						},
					},
				},
			}
			require("dropbar").setup(opts)
		end,
	},
	{
		"meain/vim-jsontogo",
		ft = "go",
	},

	{ "j-morano/buffer_manager.nvim" },
	{
		"mfussenegger/nvim-dap",
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},

	{ "aserowy/tmux.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"crispgm/nvim-tabline",
				dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
				config = function()
					require("tabline").setup({
						show_index = true, -- show tab index
						show_modify = true, -- show buffer modification indicator
						show_icon = false, -- show file extension icon
						fnamemodify = ":t", -- file name modifier
						modify_indicator = "[+]", -- modify indicator
						no_name = "No name", -- no name buffer name
						brackets = { "[", "]" }, -- file name brackets surrounding
						inactive_tab_max_length = 0, -- max length of inactive tab titles, 0 to ignore
					})
				end,
			},
			-- {
			--    "kdheepak/tabline.nvim",
			--    config = function()
			--       require("tabline").setup({
			--          options = {
			--             show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
			--             show_devicons = true, -- this shows devicons in buffer section
			--             show_bufnr = false, -- this appends [bufnr] to buffer section,
			--             show_filename_only = true, -- shows base filename only instead of relative path in filename
			--             modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
			--             show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
			--          },
			--       })
			--    end,
			-- },
		},
		config = function()
			require("shawn.lualine")
		end,
	},

	-- {
	--    "itchyny/lightline.vim",
	--    config = function()
	--       require("shawn.lightline")
	--    end,
	-- },
	{
		"vim-test/vim-test",
		event = "VeryLazy",
	},
	{ "ahmedkhalf/project.nvim" },

	{
		"danymat/neogen",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
		cmd = "Neogen",
		config = function()
			require("shawn.neogen")
		end,
	},

	{
		"andweeb/presence.nvim",
		event = "VeryLazy",
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("shawn.oil")
		end,
	},
	{ "windwp/nvim-autopairs" },
	-- {
	--    "SirVer/ultisnips",
	--    event = "InsertEnter",
	--    config = function()
	--       require("shawn.ultisnips")
	--    end,
	-- },
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			require("shawn.luasnip")
		end,
		dependencies = {
			"honza/vim-snippets",
			-- "rafamadriz/friendly-snippets",
		},
	},
	{
		"j-hui/fidget.nvim",
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "ThePrimeagen/harpoon" },
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VeryLazy",
		config = function()
			require("shawn.refactor")
		end,
	},
	-- native LSP
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		version = "^1.0.0",
		event = "VeryLazy",
		config = function()
			require("shawn.mason")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		version = "^1.0.0",
	},
	{ "neovim/nvim-lspconfig" },
	{ "mfussenegger/nvim-jdtls" },
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		enabled = utils.get_system_config().system_name == utils.system_names.work_laptop,
		opts = {
			-- See Configuration section for options
		},
		event = "VeryLazy",
		config = function()
			require("shawn.copilot_chat")
		end,
	},
	-- {
	--    "simrat39/rust-tools.nvim",
	-- },
	-- {
	--    "hrsh7th/nvim-cmp",
	--    -- event = "InsertEnter",
	--    dependencies = {
	--       "hrsh7th/cmp-nvim-lsp",
	--       "hrsh7th/cmp-nvim-lua",
	--       "hrsh7th/cmp-buffer",
	--       "andersevenrud/cmp-tmux",
	--       "hrsh7th/cmp-path",
	--       "hrsh7th/cmp-cmdline",
	--       "saadparwaiz1/cmp_luasnip",
	--       { "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
	--       -- "zbirenbaum/copilot-cmp",
	--       -- "quangnguyen30192/cmp-nvim-ultisnips",
	--       "hrsh7th/cmp-nvim-lsp-signature-help",
	--    },
	--    config = function()
	--       require("shawn.cmp")
	--    end,
	-- },
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source

		-- use a release tag to download pre-built binaries
		version = "v1.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		dependencies = {
			"L3MON4D3/LuaSnip",
			"mgalliou/blink-cmp-tmux",
			-- "andersevenrud/cmp-tmux",
			-- "giuxtaposition/blink-cmp-copilot",
			-- "zbirenbaum/copilot-cmp",
			-- "saadparwaiz1/cmp_luasnip",
			-- lock compat to tagged versions, if you've also locked blink.cmp to tagged versions
			{
				"saghen/blink.compat",
				version = "*",
				opts = { impersonate_nvim_cmp = true },
			},
		},

		config = function()
			require("shawn.blink_cmp")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("shawn.conform")
		end,
	},
	{
		"chrisbra/csv.vim",
		-- ft = { "csv" },
	},
	{
		"nvimtools/none-ls.nvim",
		event = "LspAttach",
		config = function()
			require("shawn.null-ls")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
	},
	-- {
	-- "toppair/peek.nvim",
	-- build = "deno task --quiet build:fast",
	-- ft = { "markdown" },
	-- event = "VeryLazy",
	-- config = function()
	-- require("shawn.peek")
	-- end,
	-- },

	{
		"shawnyu5/executor.nvim",
	},
	{
		"mzlogin/vim-markdown-toc",
		ft = "markdown",
	}, -- auto generate table of contents,
	{
		"jakewvincent/mkdnflow.nvim",
		ft = "markdown",
		config = function()
			require("shawn.mkdnflow")
		end,
	},
	{
		-- work with bullet lists in md nicely
		"dkarter/bullets.vim",
		ft = { "markdown", "text" },
	},
	{
		"tweekmonster/wstrip.vim",
		event = "InsertEnter",
	}, -- rmove trailing white spaces,
	{ "ferrine/md-img-paste.vim" }, -- auto paste images into markdown,
	{ "shawnyu5/mdnav" }, -- opening links in markdown,
	{
		"preservim/nerdcommenter",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = function()
					local have_make = vim.fn.executable("make") == 1
					if have_make then
						print("Using make")
						return "make"
					else
						return "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
					end
				end,
				-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
			-- "nvim-telescope/telescope-frecency.nvim",
			{
				"crispgm/telescope-heading.nvim",
				ft = { "markdown" },
			},
		},
		config = function()
			require("shawn.telescope")
		end,
	},
	{
		"Shatur/neovim-session-manager",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("shawn.session_manager")
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("shawn.neoscroll")
		end,
		enabled = utils.get_system_config().system_name ~= utils.system_names.work_laptop,
	},
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("shawn.copilot")
		end,
		event = "InsertEnter",
		enabled = utils.get_system_config().system_name == utils.system_names.work_laptop,
	},
	-- {
	--    "nvim-telescope/telescope-file-browser.nvim",
	--    dependencies = { "nvim-telescope/telescope.nvim" },
	-- },
	{ "szw/vim-maximizer" }, -- vim maxmizer,
	-- { "adelarsq/vim-matchit" }, -- matchit,
	{ "tpope/vim-surround" }, -- vim surround,
	{ "sedm0784/vim-you-autocorrect" },
	{
		"mboughaba/i3config.vim",
		config = function()
			local group = vim.api.nvim_create_augroup("i3config_ft_detection", {})
			vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
				group = group,
				pattern = "~/personal/.config/i3/config",
				callback = function()
					vim.bo.filetype = "i3config"
				end,
			})
		end,
	}, -- i3config highlighting
	{
		"alvan/vim-closetag",
		ft = { "html" },
	}, -- auto close html tags,
}

lazy.setup(pluginSpec)
