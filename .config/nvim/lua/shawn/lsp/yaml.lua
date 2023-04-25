local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")

lsp.yamlls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
      vim.lsp.handlers["textDocument/publishDiagnostics"] = nil
		-- utils.format_on_save()
		require("nvim-navic").attach(client, bufnr)
	end,
})
