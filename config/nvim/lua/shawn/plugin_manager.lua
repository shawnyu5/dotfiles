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

	-- use("dstein64/vim-startuptime")

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

	use("norcalli/nvim-colorizer.lua")
	use({
		"folke/tokyonight.nvim",
		branch = "main",
	}) -- color scheme
	-- use("preservim/tagbar")

	use({ "itchyny/lightline.vim" }) -- status bar
	use({ "vim-test/vim-test" })
	use({ "folke/which-key.nvim" })
	-- use({ "nvim-lualine/lualine.nvim" })

	use({ "ahmedkhalf/project.nvim" })

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
	})

	use({
		"danymat/neogen",
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	})

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

	use({ "hrsh7th/cmp-copilot" })
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lua")
	use("andersevenrud/cmp-tmux") -- tmux completion source
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	-- use({ "saadparwaiz1/cmp_luasnip" }) -- lua snip source
	use("quangnguyen30192/cmp-nvim-ultisnips") -- Ulti snips source
	use({ "hrsh7th/nvim-cmp" })

	use({ "jose-elias-alvarez/null-ls.nvim" })

	use({ "ray-x/lsp_signature.nvim" }) -- better lsp_signature help

	use({ "iamcco/markdown-preview.nvim" })

	use({ "shawnyu5/executor.nvim" })
	-- use("~/.config/nvim/lua/shawn/terminal/")

	use("mzlogin/vim-markdown-toc") -- auto generate table of contents
	use("tweekmonster/wstrip.vim") -- rmove trailing white spaces
	use("ferrine/md-img-paste.vim") -- auto paste images into markdown
	use("psliwka/vim-smoothie") -- smooth scrolling
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
