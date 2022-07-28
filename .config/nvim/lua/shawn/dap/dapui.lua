local ok, dapui = pcall(require, "dapui")
if not ok then
	vim.notify("dapui not installed...", vim.log.levels.WARN)
	return
end

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires >= 0.7
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				-- { id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

local dap = require("dap")
local hydra = require("shawn.hydra")
local dap_ui_autoGroup = vim.api.nvim_create_augroup("dap_ui_autoGroup", { clear = true })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
	hydra.dap_hydra:activate()
	-- stop hydra when in insert mode
	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		group = dap_ui_autoGroup,
		pattern = "*",
		callback = function()
			vim.notify("pausing hydra")
			hydra.dap_hydra:exit()
		end,
	})

	-- re enable hydra after leaving insert mode
	vim.api.nvim_create_autocmd({ "InsertLeave" }, {
		group = dap_ui_autoGroup,
		pattern = "*",
		callback = function()
			vim.notify("restarting hydra")
			hydra.dap_hydra:activate()
		end,
	})
end

-- TODO: idk why this is not being called
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
	vim.cmd(":DapVirtualTextForceRefresh")
	vim.api.nvim_clear_autocmds({
		group = dap_ui_autoGroup,
	})
	-- hydra.dap_hydra:exit()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
	vim.cmd(":DapVirtualTextForceRefresh")
	-- hydra.dap_hydra:exit()
	vim.api.nvim_clear_autocmds({
		group = dap_ui_autoGroup,
	})
end

vim.cmd("au FileType dap-repl lua require('dap.ext.autocompl').attach()")
