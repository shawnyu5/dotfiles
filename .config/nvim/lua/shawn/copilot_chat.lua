local copilot = require("CopilotChat")
local select = require("CopilotChat.select")
local chat = require("CopilotChat")

copilot.setup({
	selection = function(source)
		vim.notify("Using selection")
		return select.visual(source) or select.buffer(source)
	end,
	mappings = {
		reset = {
			normal = "<nop>",
			insert = "<nop>",
		},
	},
})

vim.keymap.set("n", "<leader>pc", function()
	chat.open()
end, { desc = "Open copilot chat" })

vim.keymap.set(
	{ "n", "v" },
	"<leader>pe",
	"<Cmd>CopilotChatExplain<CR>",
	{ desc = "Ask copilot to explain the current selection" }
)
