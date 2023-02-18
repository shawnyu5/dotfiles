local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
lsp.angularls.setup({
	on_attach = function(client, bufnr)
		-- disable rename
		client.server_capabilities.rename = false
	end,
})

