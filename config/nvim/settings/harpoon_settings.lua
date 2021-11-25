require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        excluded_filetypes = { "harpoon" }
    },
})

vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true })

-- toggle quick menu
vim.cmd('command! Harpoonshow :lua require("harpoon.ui").toggle_quick_menu()')
vim.cmd('command! Harpoonadd :lua require("harpoon.mark").add_file()')

