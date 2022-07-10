vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<C-y>")', { expr = true, silent = true })

vim.g.copilot_filetypes = { ["dap-repl"] = false, dapui_watches = false, dapui_scopes = false }

require("copilot").setup({ ft_disable = { "dap-repl", "dapui_watches", "dapui_scopes" } })
