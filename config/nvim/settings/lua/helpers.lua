local M = {}

-- function! CloseSomething()
-- if winnr("$") == 1 && tabpagenr("$") > 1 && tabpagenr() > 1 && tabpagenr() < tabpagenr("$")
-- tabclose | tabprev
-- else
-- q!
-- endif
-- endfunction

function M.leftCloser(save)
	if save then
		vim.api.nvim_command("write | q! | tabprev")
	else
		vim.api.nvim_command("q! | tabprev")
	end
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
