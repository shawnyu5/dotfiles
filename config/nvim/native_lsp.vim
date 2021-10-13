nnoremap <silent> <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <S-h> <cmd>lua vim.lsp.buf.hover()<CR>
"nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

"ccls set up
lua << EOF
require'lspconfig'.ccls.setup{}
require'lspconfig'.bashls.setup{}
EOF
