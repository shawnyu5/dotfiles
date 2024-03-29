local ok, navic = pcall(require, "nvim-navic")
if not ok then
	vim.notify("nvim-navic not installed...", vim.log.ERROR)
	return
end

local M = {}

vim.g.navic_silence = true
navic.setup({
	icons = {
		File = "F ",
		Module = "Mod ",
		Namespace = "Name ",
		Package = "Pack ",
		Class = "Class ",
		Method = "Method ",
		Property = "Pro ",
		Field = "Field ",
		Constructor = "Const ",
		Enum = "Enum ",
		Interface = "Inter ",
		Function = "Fn ",
		Variable = "Var ",
		Constant = "Const ",
		String = "Str ",
		Number = "Num ",
		Boolean = "Bool ",
		Array = "Arr ",
		Object = "Obj ",
		Key = "K ",
		Null = "N ",
		EnumMember = "EnumM ",
		Struct = "Stu ",
		Event = "Event ",
		Operator = "Oper ",
		TypeParameter = "TypeParam ",
	},
	highlight = false,
	separator = " > ",
	depth_limit = 0,
	depth_limit_indicator = "..",
	safe_output = true,
})

vim.opt.updatetime = 500
local auGroup = vim.api.nvim_create_augroup("winbar", {})
vim.api.nvim_create_autocmd({
	"CursorHold",
	"CursorMoved",
	"CursorMovedI",
	"WinScrolled",
}, {
	pattern = { "*.yml", "*.yaml", "*.json" },
	group = auGroup,
	callback = function()
		M.update()
	end,
})

--- updates the winbar from information given by nvim-navic
function M.update()
	local location = navic.get_location()
	if location == "" then
		location = " "
	end
	vim.api.nvim_set_option_value("winbar", location, { scope = "local" })
end

return M
