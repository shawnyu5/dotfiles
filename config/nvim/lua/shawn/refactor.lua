require("refactoring").setup({})

vim.api.nvim_set_keymap(
	"n",
	"<leader>db",
	":lua require('refactoring').debug.printf({below = true})<CR>",
	{ noremap = true }
)
