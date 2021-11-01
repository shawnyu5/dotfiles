" plugin manager
call plug#begin('~/.config/nvim/plugged')

" Auto pairs
Plug 'windwp/nvim-autopairs'

" Snippets engine.
Plug 'SirVer/ultisnips'
" preddefined snippets
"Plug 'honza/vim-snippets'

" lua snippets
" Plug 'L3MON4D3/LuaSnip'

Plug 'Yggdroot/indentLine'

" NERDtree
" Plug 'preservim/nerdtree'

" ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' "ranger dependicies

Plug 'shawnyu5/executor.nvim'

if has('nvim-0.5.0')
    "load telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

elseif has('nvim-0.4.3')
    "load fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'morhetz/gruvbox'

endif

"native LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
" better lsp_signature help
Plug 'ray-x/lsp_signature.nvim'
" Plug 'williamboman/nvim-lsp-installer'

"status bar
Plug 'itchyny/lightline.vim'

"COC auto completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

"brower based markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"auto generate table of contents
Plug 'mzlogin/vim-markdown-toc'
"rmove trailing white spaces
Plug 'tweekmonster/wstrip.vim'
"auto paste images into markdown
Plug 'ferrine/md-img-paste.vim'


"smooth scrolling
Plug 'psliwka/vim-smoothie'

"opening links in vim
Plug 'chmp/mdnav'

"block commenting
Plug 'preservim/nerdcommenter'

"vim maxmizer
Plug 'szw/vim-maximizer'

"matchit
Plug 'adelarsq/vim-matchit'

"vim surround
Plug 'tpope/vim-surround'

"autocorrect spelling
Plug 'sedm0784/vim-you-autocorrect'

"i3config highlighting
Plug 'mboughaba/i3config.vim'

"auto close html tags
Plug 'alvan/vim-closetag'

call plug#end()

