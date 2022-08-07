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

local hydra = require("shawn.hydra")
local dap_ui_autoGroup = vim.api.nvim_create_augroup("dap_ui_autoGroup", { clear = true })

--- Create autocmds for dap hydra on insert enter and insert leave to stop and restart hydra respectively.
---@return table the autocmd ids
local start_dap_hydra = function()
	local autocmd_ids = {}
	hydra.dap_hydra:activate()
	-- stop hydra when in insert mode
	local id = vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		group = dap_ui_autoGroup,
		pattern = "*",
		callback = function()
			hydra.dap_hydra:exit()
		end,
	})
	table.insert(autocmd_ids, id)

	-- re enable hydra after leaving insert mode
	id = vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		group = dap_ui_autoGroup,
		pattern = "*",
		callback = function()
			vim.notify("Restarting Dap Hydra")
			hydra.dap_hydra:activate()
		end,
	})
	table.insert(autocmd_ids, id)

	return autocmd_ids
end

--- clean up dap hydra by clearing and deleting all auto commands associated with it. And exiting the current hydra
---@param autocmd_ids table the autocmd ids to clean up
local cleanup_dap_hydra = function(autocmd_ids)
	vim.notify("Cleaning up hydra...")
	-- vim.api.nvim_clear_autocmds({
	-- group = dap_ui_autoGroup,
	-- })
	hydra.dap_hydra:exit()

	-- delete all autocmds in the group
	for _, id in ipairs(autocmd_ids) do
		vim.api.nvim_del_autocmd(id)
	end
end

local dap_autocmd_ids = {}
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
	dap_autocmd_ids = start_dap_hydra()
end

-- TODO: idk why this is not being called
dap.listeners.before["event_terminated"]["dapui_config"] = function()
	dapui.close()
	vim.cmd(":DapVirtualTextForceRefresh")
	cleanup_dap_hydra(dap_autocmd_ids)
end

dap.listeners.before["event_disconnect"]["dapui_config"] = function()
	vim.notify("dapui disconnected AHHHH")
	dapui.close()
	vim.cmd(":DapVirtualTextForceRefresh")
	cleanup_dap_hydra(dap_autocmd_ids)
end

dap.listeners.before.event_exited["dapui_config"] = function()
	vim.notify("dapui exited")
	dapui.close()
	vim.cmd(":DapVirtualTextForceRefresh")
	cleanup_dap_hydra(dap_autocmd_ids)
end

command("DapT", function(args)
	dap.terminate({}, {}, function()
		vim.notify("dapui terminated")
		dapui.close()
		vim.cmd(":DapVirtualTextForceRefresh")
		cleanup_dap_hydra(dap_autocmd_ids)
	end)
end, {})
