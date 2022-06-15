require("shawn.dap.dapui")
require("shawn.dap.cpp")
require("dap-go").setup()
require("shawn.dap.virtual_text")

local map = vim.keymap.set

map("n", "<leader>dc", function()
	require("dap").continue()
end)

map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end)

map("n", "<leader>do", function()
	require("dap").step_over()
end)

map("n", "<leader>di", function()
	require("dap").step_into()
end)

local command = vim.api.nvim_create_user_command
command("RunToCursor", function(args)
	require("dap").run_to_cursor()
end, {})

command("StepOut", function(args)
	require("dap").step_out()
end, {})

-- local dap_autocmd = vim.api.nvim_create_augroup("dap", {})

-- disable lsp in dap autocmd
-- vim.cmd([[ autocmd! FileType dap-repl :LspStop]])
-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
-- group = dap_autocmd,
-- pattern = "dap-repl",
-- command = "echo HIII",
-- })
