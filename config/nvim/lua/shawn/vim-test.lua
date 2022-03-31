local opts = { noremap = true }
local M = {}

local testCommands = {
	TestNearest = ":TestNearest",
	TestFile = ":TestFile",
	TestSuite = ":TestSuite",
	TestLast = ":TestLast",
	TestVisit = ":TestVisit",
}

M.selectTest = function()
	vim.ui.select(
		{ "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
		{ prompt = "Select testing options:" },
		function(selected)
			for key, command in pairs(testCommands) do
				if selected == key then
					vim.api.nvim_command(command)
				end
			end
		end
	)
end

vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('shawn.vim-test').selectTest()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ts", ":TestSuite<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ls", ":TestLast<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>tv", ":TestVisit<CR>", opts)

vim.api.nvim_exec("let test#strategy = 'neovim'", true)

return M
