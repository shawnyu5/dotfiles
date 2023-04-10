local lsp = require("lspconfig")
local utils = require("shawn.lsp.utils")
lsp.marksman.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save(bufnr)
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*.md",
	callback = function()
		vim.defer_fn(function()
			vim.notify("Restarted marksman lsp...")
			vim.cmd("LspStart")
		end, 7000)
	end,
	once = true,
})
