local M = {}

-- function! CloseSomething()
-- if winnr("$") == 1 && tabpagenr("$") > 1 && tabpagenr() > 1 && tabpagenr() < tabpagenr("$")
-- tabclose | tabprev
-- else
-- q!
-- endif
-- endfunction

--- close the current tab and move one tab to the left
--- @param save boolean whether to save the buffer or not
function M.leftCloser(save)
	if
		vim.fn.winnr("$") == 1
		and vim.fn.tabpagenr("$") > 1
		and vim.fn.tabpagenr() > 1
		and vim.fn.tabpagenr() < vim.fn.tabpagenr("$")
	then
		if save then
			vim.cmd("wa | tabclose | tabprev")
		else
			vim.cmd("q!")
		end
	else
		vim.cmd("q!")
	end

	-- -- get id of current window
	-- local win_id = vim.api.nvim_get_current_win()
	-- -- get current rab number
	-- local tab_num = vim.fn.tabpagenr()
	-- if save then
	-- vim.api.nvim_command("write | q!")
	-- else
	-- vim.api.nvim_command("q!")
	-- end

	-- print("#if vim.fn.tabpagenr():", vim.inspect(vim.fn.tabpagenr())) -- __AUTO_GENERATED_PRINT_VAR__
	-- print(" tab_num:", vim.inspect(tab_num)) -- __AUTO_GENERATED_PRINT_VAR__

	-- if vim.fn.tabpagenr() ~= tab_num then
	-- vim.api.nvim_command("tabprev")
	-- end
	-- if
	-- vim.fn.winnr("$")
	-- and vim.fn.tabpagenr("$") > 1
	-- and vim.fn.tabpagenr() > 1
	-- and vim.fn.tabpagenr() < vim.fn.tabpagenr("$")
	-- then
	-- if save == true then
	-- vim.cmd("wa! | tabclose | tabprev ")
	-- else
	-- vim.cmd("tabclose! | tabprev ")
	-- end
	-- else
	-- vim.cmd("q!")
	-- end
end

return M
