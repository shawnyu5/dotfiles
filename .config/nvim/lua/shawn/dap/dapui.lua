local ok, dapui = pcall(require, "dapui")
if not ok then
	vim.notify("dapui not installed...", vim.log.levels.WARN)
	return
end

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "disconnect",
			pause = "pause",
			play = "play",
			run_last = "last",
			step_back = "back",
			step_into = "into",
			step_out = "out",
			step_over = "over",
			terminate = "kill",
		},
	},
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

-- vim.cmd("au FileType dap-repl lua require('dap.ext.autocompl').attach()")
local dap_ui_autoGroup = vim.api.nvim_create_augroup("dap ui", {})
vim.api.nvim_create_autocmd("Filetype", {
	pattern = "dap-repl",
	callback = function()
		require("dap.ext.autocompl").attach()
	end,
})

vim.api.nvim_create_user_command("DapT", function(args)
	dap.terminate({}, {}, function()
		vim.notify("dapui terminated")
		dapui.close()
		vim.cmd(":DapVirtualTextForceRefresh")
		vim.api.nvim_delete_autocmds({
			group = dap_ui_autoGroup,
		})
		require("shawn.hydra").dap_hydra:exit()
	end)
end, {})
