local keymap = vim.keymap.set
keymap("n", "<leader>gs", function()
      require("telescope.builtin").git_status({
         git_icons = {
            added = "✅",
            changed = "✏️",
            copied = "📋",
            deleted = "🗑️",
            renamed = "➡",
            unmerged = "🔄",
            untracked = "📥",
         },
         layout_strategy = "vertical",
         initial_mode = "normal"
      })
   end,
   { desc = "Git status" })
keymap("n", "<leader>gc", function() vim.cmd("Git commit") end, { desc = "Git commit" })
keymap("n", "<leader>gp", function() vim.cmd("Git push") end, { desc = "Git push" })
keymap("n", "<leader>gf", function()
   vim.ui.input({ prompt = "Are you sure you want to force push (y/N)? " }, function(input)
      if input == "y" then
         vim.cmd("Git commit --amend --no-edit")
         vim.cmd("Git push --force")
      end
   end)
end, { desc = "Git force push, prompt for confirmation before force pushing" })
