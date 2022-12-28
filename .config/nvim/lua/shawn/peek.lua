local ok, peek = pcall(require, "peek")
if not ok then
	vim.notify("peek not installed...", vim.log.ERROR)
	return
end

peek.setup({
	auto_load = false, -- whether to automatically load preview when
	-- entering another markdown buffer
	close_on_bdelete = true, -- close preview window on buffer delete
	syntax = true, -- enable syntax highlighting, affects performance
	theme = "dark", -- 'dark' or 'light'
	update_on_change = true,
	-- relevant if update_on_change is true
	throttle_at = 200000, -- start throttling when file exceeds this
	-- amount of bytes in size
	throttle_time = "auto", -- minimum amount of time in milliseconds
	-- that has to pass before starting new render
})

local M = {}
local peek_open = false

--- toggles peek
function M.toggle()
	if peek_open then
		peek.close()
		peek_open = false
	else
		peek.open()
		peek_open = true
	end
end

vim.api.nvim_create_user_command("PeekToggle", M.toggle, {
	desc = "toggles the peek window",
})

return M
