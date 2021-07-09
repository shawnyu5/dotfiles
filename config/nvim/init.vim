 "_       _ _               _           
"(_)_ __ (_) |_      __   _(_)_ __ ___  
"| | '_ \| | __|     \ \ / / | '_ ` _ \ 
"| | | | | | |_   _   \ V /| | | | | | |
"|_|_| |_|_|\__| (_)   \_/ |_|_| |_| |_|


"autocmd BufWritePre *.cpp :norm! mmgg=G`m

"placed here for easy access
set relativenumber

"remaping leader to space
let mapleader =" "

source ~/.config/nvim/settings/plugin_manager.vim

source ~/.config/nvim/settings/sets.vim

source ~/.config/nvim/settings/fzf.vim

"source ~/.config/nvim/settings/syntastic.vim

source ~/.config/nvim/settings/coc.vim

source ~/.config/nvim/settings/markdown-preview.vim

source ~/.config/nvim/settings/maps.vim

source ~/.config/nvim/settings/vim-you-autocorrect.vim

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

"enhanced cpp highlight settings
"==============================
"Highlighting of class scope
let g:cpp_class_scope_highlight = 1

"Highlighting of member variables
"let g:cpp_member_variable_highlight = 1

"Highlighting of library concepts
let g:cpp_concepts_highlight = 1

"gruvbox settings
"=====================
autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

"improved error messages
let g:gruvbox_improved_warnings = 1

set background=dark    " Setting dark mode

"trailing white space setting
"=============================
"allow no trailing white space
let b:wstrip_trailing_max = 0

"enable stripping white space when writting to buffer
let g:wstrip_auto = 1  

"markdown image paste settings
"====================================
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR><esc>f)i<Space>=500x<Esc>F5

let cwd = $PWD . '/img'
let g:mdip_imgdir_absolute = cwd
let g:mdip_imgdir_intext = cwd

"default intext name and directory where images are saved
let g:mdip_imgdir_absolute = 'img'
let g:mdip_imgdir_intext = 'img'
let g:mdip_imgname = 'image'


"markdown table of contents setting
"===================================
let g:vmt_auto_update_on_save = 1

autocmd bufreadpre *.md,*.txt setlocal textwidth=80

"auto enable spellcheck in markdown files
au BufRead *.md setlocal spell
