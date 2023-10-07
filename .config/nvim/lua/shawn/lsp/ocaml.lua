local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
lsp.ocamllsp.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
	end,
})
