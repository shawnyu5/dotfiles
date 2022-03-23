vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<Right>", 'copilot#Accept("<Right>")', { expr = true, silent = true })
