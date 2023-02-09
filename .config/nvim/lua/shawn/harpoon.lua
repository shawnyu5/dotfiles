local ok, harpoon = pcall(require, "harpoon")
if not ok then
	print("harpoon not installed...")
	return
end

harpoon.setup({
	global_settings = {
		-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
		save_on_toggle = true,
		-- saves the harpoon file upon every change. disabling is unrecommended.
		save_on_change = true,
		-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
		enter_on_sendcmd = false,
		-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
		tmux_autoclose_windows = false,
		-- filetypes that you want to prevent from adding to the harpoon list menu.
		excluded_filetypes = { "harpoon" },
		-- set marks specific to each git branch inside git repository
		mark_branch = false,
	},
})

vim.api.nvim_set_keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true })

-- toggle quick menu
vim.api.nvim_create_user_command("Harpoonshow", function()
	require("harpoon.ui").toggle_quick_menu()
end, {
	desc = "Show harpoon quick menu",
})

vim.api.nvim_create_user_command("Harpoonadd", function()
	require("harpoon.ui").add_file()
end, {
	desc = "Add current file to harpoon",
})

vim.api.nvim_create_user_command("HarpoonCmdShow", function()
	require("harpoon.cmd-ui").toggle_quick_menu()
end, {
	desc = "Add current file to harpoon",
})
