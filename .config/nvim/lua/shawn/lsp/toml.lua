local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")

lsp.taplo.setup({
   on_attach = function(client, bufnr)
      utils.format_on_save(bufnr)
      utils.on_attach(client, bufnr)
   end,

})
