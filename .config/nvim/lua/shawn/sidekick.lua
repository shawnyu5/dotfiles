local sidekick = require("sidekick")

sidekick.setup({
	-- add any options here
	cli = {
		mux = {
			backend = "tmux",
			enabled = true,
			create = "terminal", ---@type "terminal"|"window"|"split"
		},
	},
	nes = {
		enabled = true,
	},
})

vim.keymap.set({ "n", "t", "i", "x" }, "<M-l>", function()
	require("sidekick").nes_jump_or_apply()
end, { desc = "Sidekick Toggle" })

vim.keymap.set({ "n" }, "<leader>sc", function()
	require("sidekick.cli").toggle({ name = "copilot", focus = true })
end, {
	desc = "Sidekick toggle",
})
vim.keymap.set({ "x" }, "<leader>se", function()
	require("sidekick.cli").send({
		name = "copilot",
		focus = true,
		msg = "Explain this code: {selection}",
	})
end, { desc = "Explain the selected code" })
