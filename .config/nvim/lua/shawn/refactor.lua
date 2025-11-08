local refactoring = require("refactoring")
refactoring.setup({
	print_var_statements = {
		-- add a custom print var statement for cpp
		cpp = {
			'std::cout << "%s " << %s << "\\n";',
		},
		go = {
			'fmt.Printf("%s %%v\\n", %s)',
		},
		typescriptreact = {
			[[console.log("custom print var %s %%s", JSON.stringify(%s));]],
		},
	},
	printf_statements = {
		-- add a custom printf statement for cpp
		cpp = {
			'std::cout << "%s\\n";',
		},
		go = {
			'fmt.Println("%s")',
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

vim.keymap.set({ "n", "x" }, "<leader>rr", function()
	refactoring.select_refactor()
end)
