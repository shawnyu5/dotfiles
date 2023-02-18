local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
lsp.jsonls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})
