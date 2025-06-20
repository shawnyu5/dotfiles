local lualine = require("lualine")

--- return the current harpoon mark if it exists
---@return string the harpoon mark for the statusline
local get_harpoon_status = function()
	local harpoon_mark = require("harpoon.mark")
	local mark_id = harpoon_mark.get_index_of(vim.fn.bufname())

	if not mark_id or mark_id == "" then
		return ""
	end
	return "🦈 " .. mark_id
end

lualine.setup({
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	always_show_tabline = false,
	globalstatus = true,

	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"filename",
			"diff",
			{
				"diagnostics",
				symbols = {
					error = "❌",
					warning = "⚠️",
					info = "ℹ️",
					hint = "💡",
				},
			},
		},
		lualine_c = { "branch", get_harpoon_status },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "searchcount", "selectioncount" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})

-- vim.opt.tabline = "%f"

-- local set_tabline = function()
-- local bulist = {}
-- local last_tab = vim.fn.tabpagenr("$")
-- for i = 1, last_tab do
-- -- append to bulist
-- table.insert(bulist, i)
-- end
-- print("function bulist:", vim.inspect(bulist)) -- __AUTO_GENERATED_PRINT_VAR__
-- end

-- set_tabline()
