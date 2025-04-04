local copilot = require("CopilotChat")
local select = require("CopilotChat.select")
local chat = require("CopilotChat")

copilot.setup({
	selection = function(source)
		vim.notify("Using selection")
		return select.visual(source) or select.buffer(source)
	end,
})

vim.keymap.set("n", "<leader>pc", function()
	chat.open()
end, { desc = "Open copilot chat" })

vim.keymap.set({ "n", "v" }, "<leader>pe", function()
	chat.ask(require("CopilotChat.config.prompts").COPILOT_BASE.system_prompt)
end, { desc = "Ask copilot to explain the current selection" })
