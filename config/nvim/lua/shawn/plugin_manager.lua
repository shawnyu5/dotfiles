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
	-- use "dstein64/vim-startuptime"

	-- useful dependencies
	use("nvim-lua/popup.nvim")
	use("nvim-lua/plenary.nvim")

	use("wbthomason/packer.nvim")

	use({
		"folke/tokyonight.nvim",
		branch = "main",
	}) -- color scheme
	use("preservim/tagbar")

	use({
		"itchyny/lightline.vim",
	}) -- status bar

	use({ "ahmedkhalf/project.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim" },
	})

	use({
		"preservim/nerdtree",
		-- cmd = { "NERDTree", "NERDTreeFind", "NERDTreeToggle"}
	})

	use({
		"windwp/nvim-autopairs",
	})

	use({
		"SirVer/ultisnips",
	}) --  Snippets engine.

	-- use("Yggdroot/indentLine") -- TODO: figure out why this makes title card vanish

	use({
		"ThePrimeagen/harpoon",
	})

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	-- native LSP
	use({ "neovim/nvim-lspconfig" })

	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lua")
	use("andersevenrud/cmp-tmux") -- tmux completion source
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("quangnguyen30192/cmp-nvim-ultisnips") -- Ulti snips source

	use({
		"jose-elias-alvarez/null-ls.nvim",
	})

	use({
		"hrsh7th/nvim-cmp",
	})
	use({
		"ray-x/lsp_signature.nvim",
	}) -- better lsp_signature help

	use({
		"iamcco/markdown-preview.nvim",
	})

	use({
		"shawnyu5/executor.nvim",
	})
	-- use("~/.config/nvim/lua/shawn/terminal/")

	use("mzlogin/vim-markdown-toc") -- auto generate table of contents
	use("tweekmonster/wstrip.vim") -- rmove trailing white spaces
	use("ferrine/md-img-paste.vim") -- auto paste images into markdown
	use("psliwka/vim-smoothie") -- smooth scrolling
	use("chmp/mdnav") -- opening links in vim

	use({
		"preservim/nerdcommenter",
	}) -- block commenting

	use({
		"Shatur/neovim-session-manager",
	})
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
	use({
		"alvan/vim-closetag",
	}) -- auto close html tags
end)
