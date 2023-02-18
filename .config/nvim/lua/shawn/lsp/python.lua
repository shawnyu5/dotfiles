local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
lsp.pyright.setup({
   cmd = { "pyright-langserver", "--stdio" },
   filetypes = { "python" },
   on_attach = function(client, bufnr)
      utils.on_attach(client, bufnr)
   end,
})
