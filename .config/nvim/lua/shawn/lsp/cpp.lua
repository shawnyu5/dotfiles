local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
-- clangd
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
lsp.clangd.setup({
	capabilities = capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp" },
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		utils.format_on_save()
		utils.on_attach(client, bufnr)
	end,
})


