vim.api.nvim_create_user_command("GhOpen", function()
	local file_name = vim.fn.expand("%")
	print("function file_name:", vim.inspect(file_name)) -- __AUTO_GENERATED_PRINT_VAR__
	vim.cmd("!gh browse " .. file_name)
end, {})
