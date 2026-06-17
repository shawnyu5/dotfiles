local codecompanion = require("codecompanion")
codecompanion.setup({
	interactions = {
		chat = {
			-- You can specify an adapter by name and model (both ACP and HTTP)
			adapter = {
				name = "ollama",
				model = "qwen2.5-coder:7b",
			},
		},
		-- Or, just specify the adapter by name
		inline = {
			adapter = "ollama",
			model = "qwen2.5-coder:7b",
		},
		cmd = {
			adapter = "ollama",
			model = "qwen2.5-coder:7b",
		},
		background = {
			adapter = {
				name = "ollama",
				model = "qwen2.5-coder:7b",
			},
		},
	},
	extensions = {
		spinner = {},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>pc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Open codecompanion chat" })
