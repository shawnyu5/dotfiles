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
command("DapRunToCursor", function(args)
	require("dap").run_to_cursor()
end, {})

command("DapUIToggle", function(args)
	require("dapui").toggle()
end, {})

command("DapClearBreakPoints", function(args)
	require("dap").clear_breakpoints()
end, {})

command("DapConditionalBreakpoint", function(args)
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, {})

-- local dap_autocmd = vim.api.nvim_create_augroup("dap", {})

-- disable lsp in dap autocmd
-- vim.api.nvim_create_autocmd({ "BufAdd" }, {
-- group = dap_autocmd,
-- pattern = "dap-repl",
-- callback = function()
-- print("HIII")
-- end,
-- })
