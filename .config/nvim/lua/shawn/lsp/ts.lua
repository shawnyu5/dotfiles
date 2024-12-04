local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")

lsp.tsserver.setup({
	on_attach = function(_, bufnr)
		utils.disable_formatting_on_save(bufnr)
	end,
})
