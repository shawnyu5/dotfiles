local M = {}

-- create a small terminal
function M.small_terminal()
	vim.cmd([[
      new
      wincmd J
      call nvim_win_set_height(0, 7)
      set winfixheight
      term
   ]])
end

function M.left_terminal(left)
	-- get current tab number
	local current_tab = vim.fn.tabpagenr()
	vim.cmd("tabe | term")
	if left then
		print("moving to left")
		-- move terminal to 1 before current tab, so closing terminal will land on the currect page
		vim.cmd("tabm " .. current_tab - 1)
	end
	-- go into insert mode
	vim.cmd("norm! i")
end

require("shawn.terminal.maps")

return M
