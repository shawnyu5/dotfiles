require("fff").setup()

vim.keymap.set("n", "<leader>ff", function()
   require("fff").find_files()
end, { desc = "fuzzy find all files in pwd, including hidden files" })

