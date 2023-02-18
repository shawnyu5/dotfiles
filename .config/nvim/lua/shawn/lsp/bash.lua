local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
-- bashls
lsp.bashls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
	end,
})
