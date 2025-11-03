local Snacks = require("snacks")

---@type snacks.Config
Snacks.setup({
	picker = { enabled = true },
})

vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files({
		finder = "files",
		format = "file",
		show_empty = true,
		hidden = true,
		ignored = false,
		follow = false,
		supports_live = true,
	})
end, { desc = "fuzzy find all files in pwd, including hidden files" })

vim.keymap.set("n", "<leader>fr", Snacks.picker.resume, { desc = "resume last picker search" })
vim.keymap.set("n", "<leader>fd", function()
	Snacks.picker.diagnostics()
end, { desc = "fuzzy find diagnostics" })
vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "fuzzy search all buffers" })
vim.keymap.set("n", "<leader>fw", function()
	Snacks.picker.grep()
end, { desc = "fuzzy search words" })
vim.keymap.set({ "n", "x" }, "<leader><leader>fw", function()
	Snacks.picker.grep_word()
end, { desc = "live grep for word under cursor" })

vim.keymap.set("n", "<leader>f/", Snacks.picker.lines, { desc = "Fuzzy find in current buffer" })

vim.keymap.set("n", "<leader>gb", function()
	Snacks.picker.git_branches({
		all = true,
		finder = "git_branches",
		format = "git_branch",
		preview = "git_log",
		confirm = "git_checkout",
		win = {
			input = {
				keys = {
					["<c-a>"] = { "git_branch_add", mode = { "n", "i" } },
					["<c-x>"] = { "git_branch_del", mode = { "n", "i" } },
				},
			},
		},
		---@param picker snacks.Picker
		on_show = function(picker)
			for i, item in ipairs(picker:items()) do
				if item.current then
					picker.list:view(i)
					Snacks.picker.actions.list_scroll_center(picker)
					break
				end
			end
		end,
	})
end, { desc = "fuzzy search git branches" })

vim.keymap.set("n", "<leader>fh", function()
	local ft = vim.bo.filetype
	if ft == "markdown" then
		-- TODO: replace this with a snack picker
		vim.cmd("Telescope heading")
	else
		Snacks.picker.help()
	end
end, { desc = "fuzzy search vim help tags" })
