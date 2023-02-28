vim.g.csv_nomap_h = 1
vim.g.csv_nomap_l = 1
-- always align headings to the left
vim.g.csv_arrange_align = "l*"

---Get the current column number and column name in a csv file
---@return string name <column number> - <column name> for status line
local function csv_col_name()
	if vim.opt.filetype:get() ~= "csv" then
		return ""
	end
	return "|  " .. vim.fn.CSVCol() .. " - " .. vim.fn.CSVCol("Name")
end

local csv_augroup = vim.api.nvim_create_augroup("csv_augroup", {})
vim.api.nvim_create_autocmd("InsertLeave", {
	group = csv_augroup,
	pattern = "*.csv",
	callback = function()
      -- make sure the current line is not empty, otherwise `ArrangeColumn` will throw an error
		local current_line = vim.fn.getline(".")
      if current_line ~= "" then
         vim.cmd("ArrangeColumn")
      end
	end,
	desc = "ArrangeColumn on InsertLeave",
})

vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
	group = csv_augroup,
	pattern = "*.csv",
	callback = function()
		vim.opt_local.winbar = csv_col_name()
	end,
	desc = "Update winbar with the current column number and name",
})
