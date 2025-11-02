-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1

-- Set a language to use its alternate delimiters by default
vim.g.NERDAltDelims_python = 1
vim.g.NERDDefaultAlign = "left"
vim.g.NERDCustomDelimiters = {
	swift = {
		left = "//",
	},
}

-- local augroup = vim.api.nvim_create_augroup("nerdcommenter", {})
-- vim.api.nvim_create_autocmd("BufEnter", {
--    group = augroup,
--    pattern = {"*.yml", "*.yaml"},
--    callback = function()
--       vim.g.NERDDefaultAlign = 'left'
--    end
-- })
