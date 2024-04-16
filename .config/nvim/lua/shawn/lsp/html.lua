local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")

-- Enable (broadcasting) snippet capability for completion
local capabilities_html = vim.lsp.protocol.make_client_capabilities()
capabilities_html.textDocument.completion.completionItem.snippetSupport = true

lsp.html.setup({
	capabilities = capabilities_html,
	on_attach = function(_, bufnr)
		utils.disable_formatting_on_save(bufnr)
	end,
})
