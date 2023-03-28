local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	{
		"hashivim/vim-terraform",
		ft = { "terraform" },
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
	{
		"nvim-treesitter/playground",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{ "anuvyklack/hydra.nvim" },

	{ "norcalli/nvim-colorizer.lua" },
	-- { "akinsho/git-conflict.nvim" },
	{
		"folke/tokyonight.nvim",
		branch = "main",
		dependencies = { "itchyny/lightline.vim" },
	},
	{
		"echasnovski/mini.indentscope",
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
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},

	{ "aserowy/tmux.nvim" },

	-- -- use({ "nvim-lualine/lualine.nvim" })
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

	-- -- use({ "preservim/nerdtree" })
	{
		"kyazdani42/nvim-tree.lua",
	},

	{ "windwp/nvim-autopairs" },
	{
		"SirVer/ultisnips",
		event = "InsertEnter",
		config = function()
			require("shawn.ultisnips")
		end,
	},
	{
		"honza/vim-snippets",
		event = "InsertEnter",
		dependencies = { "SirVer/ultisnips" },
	},
	{ "j-hui/fidget.nvim" },
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
		"simrat39/rust-tools.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"andersevenrud/cmp-tmux",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			{ "petertriho/cmp-git", dependencies = "nvim-lua/plenary.nvim" },
			"zbirenbaum/copilot-cmp",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			require("shawn.cmp")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" },
	},
	-- -- use({ "ray-x/lsp_signature.nvim" }) -- better lsp_signature help
	{ "zbirenbaum/copilot.lua" },
	-- -- use({ "saadparwaiz1/cmp_luasnip" }) -- lua snip source
	{
		"chrisbra/csv.vim",
		ft = { "csv" },
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
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
	{ "karb94/neoscroll.nvim" },
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
	-- "nvim-telescope/telescope-file-browser.nvim",
	-- dependencies = { "nvim-telescope/telescope.nvim" },
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
