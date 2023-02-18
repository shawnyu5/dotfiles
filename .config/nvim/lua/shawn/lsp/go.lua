local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
-- go
lsp.gopls.setup({
	on_attach = function(client, bufnr)
		utils.format_on_save()
		utils.on_attach(client, bufnr)
	end,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	init_options = {
		usePlaceholders = false,
	},
})


