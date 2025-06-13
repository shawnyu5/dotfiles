vim.api.nvim_create_user_command("GhOpen", function()
	local file_name = vim.fn.expand("%")
   local branch_name = vim.fn.system("git rev-parse --abbrev-ref HEAD")

	vim.cmd("!gh browse " .. file_name .. " --branch " .. branch_name)
end, {})
