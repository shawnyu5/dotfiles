-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_assume_mapped = true
-- vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Accept("<C-y>")', { expr = true, silent = true })

vim.g.copilot_filetypes = { ["dap-repl"] = false, dapui_watches = false, dapui_scopes = false, TelescopePrompt = false }

local ok, copilot = pcall(require, "copilot")
if not ok then
	vim.notify("copilot.lua not installed...", vim.log.ERROR)
	return
end

copilot.setup({ ft_disable = { "dap-repl", "dapui_watches", "dapui_scopes", "TelescopePrompt" } })

local ok, copilot_cmp = pcall(require, "copilot_cmp")
if not ok then
	vim.notify("copilot_cmp not installed...", vim.log.ERROR)
	return
end

copilot_cmp.setup()
