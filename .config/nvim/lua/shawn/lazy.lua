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
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	},
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-lua/popup.nvim" },

	{ "xuhdev/vim-latex-live-preview", ft = { "tex", "plaintex" } },

	-- use({ "github/copilot.vim" })

	{ "shawnyu5/do.nvim" },
	-- { "wbthomason/packer.nvim" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{ "anuvyklack/hydra.nvim" },

	-- use({
	-- "windwp/nvim-ts-autotag",
	-- requires = "nvim-treesitter/nvim-treesitter",
	-- })

	{ "norcalli/nvim-colorizer.lua" },
	{ "akinsho/git-conflict.nvim" },
	{
		"folke/tokyonight.nvim",
		branch = "main",
		dependencies = { "itchyny/lightline.vim" },
	}, -- color scheme
	-- {
	-- "SmiteshP/nvim-navic",
	-- dependencies = "neovim/nvim-lspconfig",
	-- },
	{
		"meain/vim-jsontogo",
		ft = "go",
	},

	-- use("matbme/JABS.nvim")
	{ "j-morano/buffer_manager.nvim" },

	-- dap
	{
		"mfussenegger/nvim-dap",
		{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	},

	{ "aserowy/tmux.nvim" },

	-- use({ "nvim-lualine/lualine.nvim" })
	{ "itchyny/lightline.vim" }, -- status bar,
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

	-- use({ "preservim/nerdtree" })
	{
		"kyazdani42/nvim-tree.lua",
		-- requires = {
		-- "kyazdani42/nvim-web-devicons", -- for file icons
		-- },
	},

	{ "windwp/nvim-autopairs" },
	-- use("L3MON4D3/LuaSnip")
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
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- native LSP
	{ "neovim/nvim-lspconfig" },
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
	-- use({ "ray-x/lsp_signature.nvim" }) -- better lsp_signature help
	{ "zbirenbaum/copilot.lua" },
	-- use({ "saadparwaiz1/cmp_luasnip" }) -- lua snip source
	{
		"jose-elias-alvarez/null-ls.nvim",
		opt = true,
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
	{ "shawnyu5/executor.nvim" },
	-- use("~/.config/nvim/lua/shawn/terminal/")
	{
		"mzlogin/vim-markdown-toc",
		ft = "markdown",
	}, -- auto generate table of contents,
	{
		"tweekmonster/wstrip.vim",
		event = "InsertEnter",
	}, -- rmove trailing white spaces,
	{ "ferrine/md-img-paste.vim" }, -- auto paste images into markdown,
	{ "karb94/neoscroll.nvim" },
	{ "chmp/mdnav" }, -- opening links in markdown,
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
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{ "szw/vim-maximizer" }, -- vim maxmizer,
	{ "adelarsq/vim-matchit" }, -- matchit,
	{ "tpope/vim-surround" }, -- vim surround,
	{
		"sedm0784/vim-you-autocorrect",
	},
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
local lines = {}
for line in io.lines(vim.fn.expand("~") .. ".config/nvim/system_config.json") do
	lines[#lines + 1] = line
end

local system_config = vim.fn.json_decode(lines)
if system_config.windows == true then
	table.insert(pluginSpec, {
		"williamboman/mason.nvim",
		config = function()
			require("shawn.mason")
		end,
	})
end

lazy.setup(pluginSpec, {})
