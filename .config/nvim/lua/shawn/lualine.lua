local ok, lualine = pcall(require, "lualine")
if not ok then
	vim.notify("lualine not installed...", vim.log.levels.WARN)
	return
end

M = {}

local fileName = function()
	return vim.fn.expand("%:t")
end

lualine.setup({
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
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
	tabline = {
		-- lualine_a = { mode = 0 },
		-- lualine_b = { fileName },
		-- lualine_c = { "filename" },
		-- lualine_x = {},
		-- lualine_y = {},
		-- lualine_z = {},
	},
	extensions = {},
})
