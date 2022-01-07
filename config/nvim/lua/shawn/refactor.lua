require("refactoring").setup({})

vim.api.nvim_set_keymap(
	"v",
	"<leader>db",
	":lua require('refactoring').debug.print_var({})<CR>",
	{ noremap = true }
)
