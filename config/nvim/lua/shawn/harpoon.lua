local ok, harpoon = pcall(require, "harpoon")
if not ok then
   print("harpoon not installed...")
   return
end

harpoon.setup()

vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true })

-- toggle quick menu
vim.cmd('command! Harpoonshow :lua require("harpoon.ui").toggle_quick_menu()')
vim.cmd('command! Harpoonadd :lua require("harpoon.mark").add_file()')

-- vim.api.nvim_set_keymap("n", "<leader><leader>1", '<cmd>lua require("harpoon.mark").add_file()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader><leader>2", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true })
