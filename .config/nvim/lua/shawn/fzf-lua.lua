local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>ff", function()
	fzf.files()
end, { desc = "fuzzy find all files in pwd, including hidden files" })

vim.keymap.set("n", "<leader>fr", fzf.resume, { desc = "resume last fzf search" })
