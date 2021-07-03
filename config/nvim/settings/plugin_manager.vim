"plugin manager
call plug#begin('~/.config/nvim/plugged')

"status bar
Plug 'itchyny/lightline.vim'

"auto paste images into markdown
Plug 'ferrine/md-img-paste.vim'

"COC auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"center current text
"Plug 'junegunn/goyo.vim'

"brower based markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"error checking
"Plug 'vim-syntastic/syntastic'

"table of contents
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

"vim in the browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

"fzf plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"vim surround
Plug 'tpope/vim-surround'

"autocorrect spelling
Plug 'sedm0784/vim-you-autocorrect'

"i3config highlighting
Plug 'mboughaba/i3config.vim'

"nvim native lsp
"Plug 'neovim/nvim-lspconfig'

call plug#end()

