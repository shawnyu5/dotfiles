"markdown preview settings
"==============================
" set to 1, nvim will open the preview window after entering the markdown buffer
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
let g:mkdp_refresh_slow = 1

" specify browser to open preview page
let g:mkdp_browser = 'chrome'

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = '~/personal/gitHub_markdown.css'

"MarkdownPreview mapped to leader m
autocmd FileType markdown nnoremap <leader>m :MarkdownPreview<Enter>
