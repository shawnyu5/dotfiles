vim.api.nvim_create_augroup("formatOptions", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	command = "setlocal formatoptions-=cro",
})

vim.api.nvim_create_augroup("makeFileIndent", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "make",
	command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4",
})

vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank({ timeout = 104 })
	end,
})
