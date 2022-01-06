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

-- sources a vim file
local function source(file)
	vim.cmd("source " .. file)
end
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
		"jose-elias-alvarez/null-ls.nvim",
		config = require("shawn.null-ls"),
	})

	use({
		"folke/tokyonight.nvim",
		branch = "main",
		config = require("shawn.tokyo-knight"),
	}) -- color scheme

	use({
		"itchyny/lightline.vim",
		config = source("~/.config/nvim/settings/lightLine_settings.vim"),
	}) -- status bar

	use({
		"nvim-telescope/telescope.nvim",
		config = require("shawn.telescope")
	})
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = require("shawn.tree-sitter"),
	})

	use("nvim-telescope/telescope-file-browser.nvim")
	use({
		"preservim/nerdtree",
		config = source("~/.config/nvim/settings/NERDtree_settings.vim"),
		-- cmd = { "NERDTree", "NERDTreeFind", "NERDTreeToggle"}
	})

	use({
		"windwp/nvim-autopairs",
		config = require("shawn.autopairs"),
	})

	use({
		"SirVer/ultisnips",
		config = require("shawn.ultisnips"),
	}) --  Snippets engine.

	-- use 'Yggdroot/indentLine' -- TODO: figure out why this makes title card vanish

	use({
		"ThePrimeagen/harpoon",
		config = require("shawn.harpoon"),
	})

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
      config = require("shawn.refactor")
	})

	-- native LSP
	use({ "neovim/nvim-lspconfig", config = require("shawn.lsp") })

	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-nvim-lua")
	use("andersevenrud/cmp-tmux") -- tmux completion source
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("quangnguyen30192/cmp-nvim-ultisnips") -- Ulti snips source

	use({
		"hrsh7th/nvim-cmp",
		config = require("shawn.cmp"),
	})
	use({
		"ray-x/lsp_signature.nvim",
		config = require("shawn.lsp_signature"),
	}) -- better lsp_signature help

	use({
		"iamcco/markdown-preview.nvim",
		config = source("~/.config/nvim/settings/markdown-preview.vim"),
	})

	use({
		"shawnyu5/executor.nvim",
		config = require("shawn.executor_settings"),
	})

	use("mzlogin/vim-markdown-toc") -- auto generate table of contents
	use("tweekmonster/wstrip.vim") -- rmove trailing white spaces
	use("ferrine/md-img-paste.vim") -- auto paste images into markdown
	use("psliwka/vim-smoothie") -- smooth scrolling
	use("chmp/mdnav") -- opening links in vim

	use({
		"preservim/nerdcommenter",
		config = source("~/.config/nvim/settings/nerdcommenter_settings.vim"),
	}) -- block commenting

	use("szw/vim-maximizer") -- vim maxmizer
	use("adelarsq/vim-matchit") -- matchit
	use("tpope/vim-surround") -- vim surround
	use({
		"sedm0784/vim-you-autocorrect",
		config = source("~/.config/nvim/settings/vim-you-autocorrect.vim"),
	}) -- autocorrect spelling
	use({
		"mboughaba/i3config.vim",
		config = function()
			print("Hiiii")
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
		config = source("~/.config/nvim/settings/vim-closetag.vim"),
	}) -- auto close html tags
end)
