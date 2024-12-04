local lsp = require("lspconfig")
lsp.yamlls.setup({
	on_attach = function()
		-- vim.lsp.handlers["textDocument/publishDiagnostics"] = nil
	end,
})
