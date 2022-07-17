local ok, refactoring = pcall(require, "refactoring")
if not ok then
	vim.notify("refactoring not installed...", vim.log.levels.WARN)
	return
end
refactoring.setup({
	print_var_statements = {
		-- add a custom print var statement for cpp
		cpp = {
			'std::cout << "%s " << %s << "\\n";',
		},
	},
	printf_statements = {
		-- add a custom printf statement for cpp
		cpp = {
			'std::cout << "%s\\n";',
		},
	},
})

-- vim.keymap.set("v", "<leader>rv", require("refactoring").debug.print_var({}), { noremap = true })

-- print debugging in visual mode
vim.keymap.set("v", "<leader>rv", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })
-- print debugging in normal mode
vim.keymap.set(
	"n",
	"<leader>rv",
	":lua require('refactoring').debug.print_var({ normal = true })<CR>",
	{ noremap = true }
)

-- Cleanup function: this remap should be made in normal mode
vim.api.nvim_set_keymap("n", "<leader>rc", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rf", ":lua require('refactoring').debug.printf({})<CR>", { noremap = true })

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
