require("shawn.dap.dapui")
require("shawn.dap.cpp")

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
