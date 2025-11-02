local comment = require("Comment")

comment.setup({
	{
		---Add a space b/w comment and the line
		padding = true,
		---Whether the cursor should stay at its position
		sticky = true,
		---Lines to be ignored while (un)comment
		ignore = nil,
		---LHS of extra mappings
		---Enable keybindings
		---NOTE: If given `false` then the plugin won't create any mappings
		mappings = {
			---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
			basic = false,
			---Extra mapping; `gco`, `gcO`, `gcA`
			extra = false,
		},
		---Function to call before (un)comment
		pre_hook = nil,
		---Function to call after (un)comment
		post_hook = nil,
	},
})

local api = require("Comment.api")
local utils = require("Comment.utils")

vim.keymap.set("n", "<leader>cc", function()
	api.comment.linewise()
end, {
	desc = "Comment a line",
})

vim.keymap.set("n", "<leader>cu", function()
	api.uncomment.linewise()
end, {
	desc = "Uncomment a single line",
})

vim.keymap.set("v", "<leader>cc", function()
	local range = utils.CommentRange
	-- __AUTO_GENERATED_PRINT_VAR_START__
	print([==[(anon) range:]==], vim.inspect(range)) -- __AUTO_GENERATED_PRINT_VAR_END__
	api.uncomment.linewise()
end, {
	desc = "Comment a block",
})

vim.keymap.set("v", "<leader>cu", function()
	api.uncomment.blockwise()
end, {
	desc = "Uncomment a block",
})
