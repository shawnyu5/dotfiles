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

local pluginSpec = {
	{ "folke/lazy.nvim" },
	{ "tpope/vim-fugitive" },
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	{ "xuhdev/vim-latex-live-preview", ft = { "tex", "plaintex" } },
	-- -- use({ "github/copilot.vim" })

	-- {
	-- "shawnyu5/do.nvim",
	-- -- dir = "/home/shawn/do.nvim",
	-- },
	-- -- { "wbthomason/packer.nvim" },
	{ "NFrid/due.nvim" },
	-- {
	--    "hashivim/vim-terraform",
	--    ft = { "terraform" },
	-- },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
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
		lazy = false,
		-- event = "VeryLazy",
		config = function()
			require("shawn.tree-sitter")
		end,
	},
	-- {
	-- "nvim-treesitter/playground",
	-- dependencies = "nvim-treesitter/nvim-treesitter",
	-- },
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{ "anuvyklack/hydra.nvim" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "akinsho/git-conflict.nvim" },
	{
		"folke/tokyonight.nvim",
		branch = "main",
		dependencies = { "itchyny/lightline.vim" },
	},
	{
		"echasnovski/mini.indentscope",
	},
	{
		"Bekaboo/dropbar.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local opts = {
				icons = {
					enable = false,
				},
			}
			require("dropbar").setup(opts)
		end,
	},
	-- {
	-- "sindrets/diffview.nvim",
	-- dependencies = { "nvim-lua/plenary.nvim" },
	-- event = "VeryLazy",
	-- config = function()
	-- require("shawn.diffview")
	-- end,
	-- },
	-- {
	-- "3699394/diffview.nvim",
	-- dependencies = { "nvim-lua/plenary.nvim" },
	-- event = "VeryLazy",
	-- config = function()
	-- require("shawn.diffview")
	-- end,
	-- },
	-- {
	-- "glepnir/zephyr-nvim",
	-- config = function()
	-- require("zephyr")
	-- -- make background transparent
	-- local set_hl = vim.api.nvim_set_hl
	-- set_hl(0, "Normal", {
	-- bg = "none",
	-- })
	-- set_hl(0, "NormalFloat", {
	-- bg = "none",
	-- })
	-- -- set_hl(0, "FloatBorder", {
	-- -- bg = "yellow",
	-- -- })
	-- set_hl(0, "CmpDocumentation", {
	-- bg = "gray",
	-- })
	-- end,
	-- },
	{
		"meain/vim-jsontogo",
		ft = "go",
	},

	-- -- use("matbme/JABS.nvim")
	{ "j-morano/buffer_manager.nvim" },

	-- dap
	{
		"mfussenegger/nvim-dap",
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},

	{ "aserowy/tmux.nvim" },

	-- { "nvim-lualine/lualine.nvim" },
	{
		"itchyny/lightline.vim",
		config = function()
			require("shawn.lightline")
		end,
	}, -- status bar,
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

	{ "andweeb/presence.nvim" },
	-- {
	--    "preservim/nerdtree",
	--    -- cmd = { "NERDTreeToggle", "NERDTreeFind" },
	--    config = function()
	--       require("shawn.nerdtree")
	--    end,
	-- },
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
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
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		config = function()
			require("shawn.luasnip")
		end,
		-- dependencies = { "molleweide/LuaSnip-snippets.nvim" },
	},
	{
		"honza/vim-snippets",
		-- event = "InsertEnter",
		-- dependencies = { "SirVer/ultisnips" },
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
	},
	{ "lukas-reineke/indent-blankline.nvim" },
	{ "ThePrimeagen/harpoon" },
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- native LSP
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		event = "VeryLazy",
		config = function()
			require("shawn.mason")
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
	},
	{ "neovim/nvim-lspconfig" },
	{ "mfussenegger/nvim-jdtls" },
	{
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},
	-- {
	--    "simrat39/rust-tools.nvim",
	-- },
	{
		"hrsh7th/nvim-cmp",
		-- event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			{ "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
			-- "zbirenbaum/copilot-cmp",
			-- "quangnguyen30192/cmp-nvim-ultisnips",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			require("shawn.cmp")
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("shawn.conform")
		end,
	},

	-- {
	-- "lewis6991/gitsigns.nvim",
	-- config = function()
	-- require("gitsigns").setup()
	-- end,
	-- },
	-- {
	-- "SmiteshP/nvim-navic",
	-- dependencies = { "neovim/nvim-lspconfig" },
	-- },
	-- -- use({ "ray-x/lsp_signature.nvim" }) -- better lsp_signature help
	-- { "zbirenbaum/copilot.lua" },
	-- -- use({ "saadparwaiz1/cmp_luasnip" }) -- lua snip source
	{
		"chrisbra/csv.vim",
		ft = { "csv" },
	},
	{
		-- "jose-elias-alvarez/null-ls.nvim",
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
	{ "preservim/nerdcommenter" }, -- block commenting,
	{ "nvim-telescope/telescope.nvim" },
	{
		"Shatur/neovim-session-manager",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- {
	--    "nvim-telescope/telescope-file-browser.nvim",
	--    dependencies = { "nvim-telescope/telescope.nvim" },
	-- },
	{ "szw/vim-maximizer" }, -- vim maxmizer,
	{ "adelarsq/vim-matchit" }, -- matchit,
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

local utils = require("shawn.utils")
if utils.get_system_config().system_name ~= utils.system_names.work_laptop then
	-- table.insert(pluginSpec, {
	--    "Exafunction/codeium.nvim",
	--    dependencies = {
	--       "nvim-lua/plenary.nvim",
	--       "hrsh7th/nvim-cmp",
	--    },
	--    config = function()
	--       require("codeium").setup({})
	--    end,
	-- })

	table.insert(pluginSpec, {
		"karb94/neoscroll.nvim",
		config = function()
			require("shawn.neoscroll")
		end,
	})
end

lazy.setup(pluginSpec, {
	root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
	defaults = {
		lazy = false, -- should plugins be lazy-loaded?
		version = nil,
		-- version = "*", -- enable this to try installing the latest stable versions of plugins
	},
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
	concurrency = nil, ---@type number limit the maximum amount of concurrent tasks
	git = {
		-- defaults for the `Lazy log` command
		-- log = { "-10" }, -- show the last 10 commits
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 120, -- kill processes that take more than 2 minutes
		url_format = "https://github.com/%s.git",
	},
	dev = {
		-- directory where you store your local plugin projects
		path = "~/projects",
		---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
		patterns = {}, -- For example {"folke"}
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = {},
	},
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			source = "📄",
			start = "🚀",
			task = "📌",
		},
		throttle = 20, -- how frequently should the ui process render events
		custom_keys = {
			-- you can define custom key maps here.
			-- To disable one of the defaults, set it to false

			-- open lazygit log
			["<localleader>l"] = function(plugin)
				require("lazy.util").open_cmd({ "lazygit", "log" }, {
					cwd = plugin.dir,
					terminal = true,
					close_on_exit = true,
					enter = true,
				})
			end,
			-- open a terminal for the plugin dir
			["<localleader>t"] = function(plugin)
				require("lazy.util").open_cmd({ vim.go.shell }, {
					cwd = plugin.dir,
					terminal = true,
					close_on_exit = true,
					enter = true,
				})
			end,
		},
	},
	diff = {
		-- diff command <d> can be one of:
		-- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
		--   so you can have a different command for diff <d>
		-- * git: will run git diff and open a buffer with filetype git
		-- * terminal_git: will open a pseudo terminal with git diff
		-- * diffview.nvim: will open Diffview to show the diff
		cmd = "git",
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = true,
		notify = true, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
			path = vim.fn.stdpath("cache") .. "/lazy/cache",
			-- Once one of the following events triggers, caching will be disabled.
			-- To cache all modules, set this to `{}`, but that is not recommended.
			-- The default is to disable on:
			--  * VimEnter: not useful to cache anything else beyond startup
			--  * BufReadPre: this will be triggered early when opening a file from the command line directly
			disable_events = { "VimEnter", "BufReadPre" },
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[]
			paths = {}, -- add any custom paths here that you want to indluce in the rtp
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
	-- lazy can generate helptags from the headings in markdown readme files,
	-- so :help works even for plugins that don't have vim docs.
	-- when the readme opens with :help it will be correctly displayed as markdown
	readme = {
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md" },
		-- only generate markdown helptags for plugins that dont have docs
		skip_if_doc_exists = true,
	},
})
