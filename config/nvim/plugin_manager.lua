local ok, packer = pcall(require, "packer")
if not ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end
    }
}

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
use 'wbthomason/packer.nvim'
use {
    'folke/tokyonight.nvim',
    { branch = 'main' },
    config = require("shawn.tokyo-knight")
} -- color scheme

-- useful dependencies
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'


use {
    'nvim-telescope/telescope.nvim',
    config = source("~/.config/nvim/settings/telescope.vim")
}
use {
    'nvim-treesitter/nvim-treesitter',
    { run = ':TSUpdate | :TSInstall javascript bash lua python cpp vim'},
    config = require("shawn.tree-sitter")
}
use 'nvim-telescope/telescope-file-browser.nvim'
use {
    'preservim/nerdtree',
    config = source("~/.config/nvim/settings/NERDtree_settings.vim")
}

use {
    'windwp/nvim-autopairs',
    config = require("shawn.autopairs")
}

use {
    'SirVer/ultisnips',
    config = source("~/.config/nvim/settings/utilsnips_settings.vim")
} --  Snippets engine.

use 'Yggdroot/indentLine'
use {
    'ThePrimeagen/harpoon',
    config = require("shawn.harpoon")
}

-- native LSP
use 'neovim/nvim-lspconfig'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'andersevenrud/cmp-tmux' -- tmux completion source
use 'quangnguyen30192/cmp-nvim-ultisnips' -- Ulti snips source
use 'ray-x/lsp_signature.nvim' -- better lsp_signature help
use {
    'itchyny/lightline.vim',
    config = source("~/.config/nvim/settings/lightLine_settings.vim")

} -- status bar
use {
    'iamcco/markdown-preview.nvim',
    opt = true,
    ft = "markdown",
    run = ":mkdp#util#install()",
    config = source("~/.config/nvim/settings/markdown-preview.vim")
} -- brower based markdown preview


use {
    'shawnyu5/executor.nvim',
    config = require("shawn.executor_settings")

}
use 'mzlogin/vim-markdown-toc' -- auto generate table of contents
use 'tweekmonster/wstrip.vim' -- rmove trailing white spaces
use 'ferrine/md-img-paste.vim' -- auto paste images into markdown
use 'psliwka/vim-smoothie' -- smooth scrolling
use 'chmp/mdnav' -- opening links in vim
use {
    'preservim/nerdcommenter',
    config = source("~/.config/nvim/settings/nerdcommenter_settings.vim")
} -- block commenting
use 'szw/vim-maximizer' -- vim maxmizer
use 'adelarsq/vim-matchit' -- matchit
use 'tpope/vim-surround' -- vim surround
use 'sedm0784/vim-you-autocorrect' -- autocorrect spelling
use 'mboughaba/i3config.vim' -- i3config highlighting
use 'alvan/vim-closetag' -- auto close html tags


end)
