require("shawn.dap.dapui")
require("shawn.dap.cpp")
require("dap-go").setup()
require("shawn.dap.virtual_text")

-- - `DapBreakpoint` for breakpoints (default: `B`)
-- - `DapBreakpointCondition` for conditional breakpoints (default: `C`)
-- - `DapLogPoint` for log points (default: `L`)
-- - `DapStopped` to indicate where the debugee is stopped (default: `→`)
-- - `DapBreakpointRejected` to indicate breakpoints rejected by the debug
-- adapter (default: `R`)

-- You can customize the signs by overriding their definitions after you've
-- loaded `dap`. For example:

-- >
-- lua << EOF
-- require('dap')
-- vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
-- EOF

local map = vim.keymap.set
local dap = require("dap")
local dapui = require("dapui")

map("n", "<leader>dc", function()
	dap.continue()
end)
map("n", "<leader>db", function()
	dap.toggle_breakpoint()
end)
map("n", "<leader>do", function()
	dap.step_over()
end)
map("n", "<leader>di", function()
	dap.step_into()
end)
-- show the scopes window in float element
map("n", "<leader>df", function()
	dapui.float_element("scopes", { enter = true, width = 75 })
end)

local command = vim.api.nvim_create_user_command

command("DapRunToCursor", function(args)
	dap.run_to_cursor()
end, {})
command("DapUIToggle", function(args)
	require("dapui").toggle()
end, {})
command("DapClearBreakPoints", function(args)
	dap.clear_breakpoints()
end, {})
command("DapConditionalBreakpoint", function(args)
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, {})
command("DapLogPoint", function(args)
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
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
