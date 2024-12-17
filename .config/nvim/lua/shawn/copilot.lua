local copilot = require("copilot")
copilot.setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		hide_during_completion = true,
		debounce = 75,
		keymap = {
			accept = "<M-l>",
			accept_word = false,
			accept_line = false,
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},
	panel = {
		enabled = true,
	},

	filetypes = {
		yaml = true,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
		["dap-repl"] = false,
		["dapui_watches"] = false,
		["dapui_scopes"] = false,
		["TelescopePrompt"] = false,
	},
})
