require("shawn.dap.dapui")
require("shawn.dap.cpp")
-- require("shawn.dap.javascript")
require("dap-go").setup()
-- require("shawn.dap.javascript")
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
end, { desc = "Dap Continue" })

map("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Dap Toggle breakpoint" })

map("n", "<leader>do", function()
	dap.step_over()
end, { desc = "Dap Step over" })

map("n", "<leader>di", function()
	dap.step_into()
end, { desc = "Dap Step into" })

-- show the scopes window in float element
map("n", "<leader>df", function()
	dapui.float_element("scopes", { enter = true, width = 75 })
end, { desc = "Dap toggle scopes in floating window" })

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

-- delete the DapTerminate event and replace with my own
-- vim.api.nvim_del_user_command("DapTerminate")

command("DapT", function(args)
	dap.terminate({}, {}, function()
		vim.notify("dapui terminated")
		dapui.close()
		vim.cmd(":DapVirtualTextForceRefresh")
		vim.api.nvim_clear_autocmds({
			group = dap_ui_autoGroup,
		})
		require("shawn.hydra").dap_hydra:exit()
	end)
end, {})
