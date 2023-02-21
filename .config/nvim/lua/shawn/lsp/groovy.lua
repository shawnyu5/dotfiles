local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
lsp.groovyls.setup({
	cmd = { "groovy-language-server" },
   on_attach = function(client, bufnr)
      utils.on_attach(client, bufnr)
   end
})
