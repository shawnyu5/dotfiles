local ok, buffer = pcall(require, "buffer_manager.ui")
if not ok then
	vim.notify("buffer_manager not installed...", vim.log.ERROR)
	return
end

vim.api.nvim_create_user_command("JABS", function()
	buffer.toggle_quick_menu()
end, {
	desc = "Toggle buffer manager quick menu",
})
