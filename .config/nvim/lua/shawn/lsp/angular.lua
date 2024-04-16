local lsp = require("lspconfig")
lsp.angularls.setup({
	on_attach = function(client, bufnr)
		-- disable rename
		client.server_capabilities.rename = false
	end,
})

