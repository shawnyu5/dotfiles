local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")

-- Enable (broadcasting) snippet capability for completion
local capabilities_html = vim.lsp.protocol.make_client_capabilities()
capabilities_html.textDocument.completion.completionItem.snippetSupport = true

lsp.html.setup({
	capabilities = capabilities_html,
	on_attach = function(client, bufnr)
      utils.disable_formatting(client)
      utils.format_on_save(bufnr)
		utils.on_attach(client, bufnr)
	end,
})
