local copilot = require("CopilotChat")
local chat = require("CopilotChat")

copilot.setup({
	mappings = {
		reset = {
			normal = "<nop>",
			insert = "<nop>",
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>pc", function()
	chat.open()
end, { desc = "Open copilot chat" })

vim.keymap.set(
	{ "n", "v" },
	"<leader>pe",
	"<Cmd>CopilotChatExplain<CR>",
	{ desc = "Ask copilot to explain the current selection" }
)

vim.keymap.set("n", "<leader>pm", "<Cmd>CopilotChatModels<CR>", {
	desc = "List available models",
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "copilot-*",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})
