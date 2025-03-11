local keymap = vim.keymap.set

---run git add -A
local function git_add_all()
	vim.cmd("Git add -A")
	vim.notify("git added all changes")
end

keymap("n", "<leader>gs", function()
	if vim.fn.system("git -C " .. vim.fn.getcwd(-1, 0) .. " status --porcelain") ~= "" then
		require("telescope.builtin").git_status({
			git_icons = {
				added = "✅",
				changed = "🖊️",
				copied = "📋",
				deleted = "🗑️",
				renamed = "➡",
				unmerged = "🔄",
				untracked = "🆕",
			},
			layout_strategy = "vertical",
			initial_mode = "normal",
		})
	else
		vim.notify("No git changes", {
			level = vim.log.levels.WARN,
		})
	end
end, { desc = "Git status" })
keymap("n", "<leader>gc", function()
	vim.cmd("silent! Git commit")
end, { desc = "Git commit" })
keymap("n", "<leader>ga", function()
	git_add_all()
end, { desc = "Git add -A" })
keymap("n", "<leader>gp", function()
	vim.cmd("Git push")
end, { desc = "Git push" })
keymap("n", "<leader>gf", function()
	vim.ui.input({ prompt = "Are you sure you want to force push (y/N)? " }, function(input)
		if input == "y" then
			vim.cmd("silent! Git commit --amend --no-edit")
			vim.cmd("Git push --force-with-lease")
		end
	end)
end, { desc = "Git force push, prompt for confirmation before force pushing" })
