local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

local ok, packer = pcall(require, "packer")
if not ok then
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- auto install plugins upon saving file
-- vim.cmd [[
-- augroup packer_config
-- autocmd!
-- autocmd BufWritePost plugin_manager.lua source <afile> | PackerSync
-- ]]

return packer.startup(function(use)
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end

	use("dstein64/vim-startuptime")

	-- useful dependencies
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")

	use({ "github/copilot.vim" })

	use("wbthomason/packer.nvim")
	use("nathom/filetype.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({
		"windwp/nvim-ts-autotag",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	use("norcalli/nvim-colorizer.lua")
	use("akinsho/git-conflict.nvim")
	use({
		"folke/tokyonight.nvim",
		branch = "main",
	}) -- color scheme
	use("fgheng/winbar.nvim")
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})

	use("matbme/JABS.nvim")

	-- dap
	use({
		"mfussenegger/nvim-dap",
		{ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },
		"leoluz/nvim-dap-go",
		"theHamsta/nvim-dap-virtual-text",
	})

	use("aserowy/tmux.nvim")

	use({ "itchyny/lightline.vim" }) -- status bar
	use({ "vim-test/vim-test" })
	use({ "ahmedkhalf/project.nvim" })

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
	})

	use({
		"danymat/neogen",
		requires = "nvim-treesitter/nvim-treesitter",
		opt = true,
		cmd = "Neogen",
		config = function()
			require("shawn.neogen")
		end,
	})

	use("andweeb/presence.nvim")

	use({
		"preservim/nerdtree",
		-- cmd = { "NERDTree", "NERDTreeFind", "NERDTreeToggle"}
	})

	use({ "windwp/nvim-autopairs" })

	-- use("L3MON4D3/LuaSnip")
	use({ "SirVer/ultisnips" }) --  Snippets engine.
	use("honza/vim-snippets")

	use("j-hui/fidget.nvim")
	-- use("Yggdroot/indentLine") -- TODO: figure out why this makes title card vanish

	use({ "ThePrimeagen/harpoon" })

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- native LSP
	use({ "neovim/nvim-lspconfig" })

	use({
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"andersevenrud/cmp-tmux",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" },
		"zbirenbaum/copilot-cmp",
		"quangnguyen30192/cmp-nvim-ultisnips",
	})
	use("zbirenbaum/copilot.lua")

	-- use({ "saadparwaiz1/cmp_luasnip" }) -- lua snip source

	use({ "jose-elias-alvarez/null-ls.nvim" })

	use({ "ray-x/lsp_signature.nvim" }) -- better lsp_signature help

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use({ "shawnyu5/executor.nvim" })
	-- use("~/.config/nvim/lua/shawn/terminal/")

	use("mzlogin/vim-markdown-toc") -- auto generate table of contents
	use("tweekmonster/wstrip.vim") -- rmove trailing white spaces
	use("ferrine/md-img-paste.vim") -- auto paste images into markdown
	-- use({ "psliwka/vim-smoothie", commit = "f2aaab110b49da21ab7abf4858173e3194109f6a" }) -- smooth scrolling
	use("karb94/neoscroll.nvim")
	use("chmp/mdnav") -- opening links in vim

	use({ "preservim/nerdcommenter" }) -- block commenting
	use({ "Shatur/neovim-session-manager" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })

	use("szw/vim-maximizer") -- vim maxmizer
	use("adelarsq/vim-matchit") -- matchit
	use("tpope/vim-surround") -- vim surround
	use({
		"sedm0784/vim-you-autocorrect",
	}) -- autocorrect spelling
	use({
		"mboughaba/i3config.vim",
		config = function()
			vim.cmd([[
         aug i3config_ft_detection
         au!
         au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
         aug end
         ]])
		end,
	}) -- i3config highlighting
	use({ "alvan/vim-closetag" }) -- auto close html tags
end)
