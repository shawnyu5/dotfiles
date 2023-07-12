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
         layout_strategy = "vertical"
      })
   end,
   { desc = "Git status" })
keymap("n", "<leader>gc", function() vim.cmd("Git commit") end, { desc = "Git commit" })
