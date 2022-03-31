local opts = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ts", ":TestSuite<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ls", ":TestLast<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>tv", ":TestVisit<CR>", opts)

vim.api.nvim_exec("let test#strategy = 'neovim'", true)
