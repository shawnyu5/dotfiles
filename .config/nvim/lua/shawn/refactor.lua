local ok, refactoring = pcall(require, "refactoring")
if not ok then
	print("refactoring not installed...")
	return
end
refactoring.setup({})

vim.api.nvim_set_keymap("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
