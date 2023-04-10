local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")

-- tsserver
lsp.tsserver.setup({
	on_attach = function(client, bufnr)
      utils.disable_formatting(client)
		utils.format_on_save(bufnr)
		utils.on_attach(client, bufnr)
	end,
})


