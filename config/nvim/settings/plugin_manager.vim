"plugin manager
call plug#begin('~/.config/nvim/plugged')

"telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"native LSP
"Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/nvim-compe'
""code action
"Plug 'glepnir/lspsaga.nvim'

"status bar
Plug 'itchyny/lightline.vim'

"auto paste images into markdown
Plug 'ferrine/md-img-paste.vim'

"COC auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"brower based markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"auto generate table of contents
Plug 'mzlogin/vim-markdown-toc'

"smooth scrolling
Plug 'psliwka/vim-smoothie'

"opening links in vim
Plug 'chmp/mdnav'

"rmove trailing white spaces
Plug 'tweekmonster/wstrip.vim'

"vim color scheme
"Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'

"block commenting
Plug 'preservim/nerdcommenter'

"vim maxmizer
Plug 'szw/vim-maximizer'

"enhanced cpp highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

"matchit
Plug 'adelarsq/vim-matchit'

"fzf plugin
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

"vim surround
Plug 'tpope/vim-surround'

"autocorrect spelling
Plug 'sedm0784/vim-you-autocorrect'

"i3config highlighting
Plug 'mboughaba/i3config.vim'

call plug#end()

