local lsp = require("lspconfig")
lsp.marksman.setup({})

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
