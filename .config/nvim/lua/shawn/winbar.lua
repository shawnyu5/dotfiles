local M = {}
local navic = require("nvim-navic")

vim.g.navic_silence = true
navic.setup({
	icons = {
		File = "File ",
		Module = "Module ",
		Namespace = "Namespace ",
		Package = "Package ",
		Class = "Class ",
		Method = "Method ",
		Property = "Property ",
		Field = "Field ",
		Constructor = "Constructor ",
		Enum = "Enum ",
		Interface = "Interface ",
		Function = "Function ",
		Variable = "Variable ",
		Constant = "Constant ",
		String = "String ",
		Number = "Number ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = "Struct",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	separator = " > ",
	depth_limit = 5,
	depth_limit_indicator = "..",
})

local ignore_ft = {
	"TelescopePrompt",
	"harpoon",
}
local auGroup = vim.api.nvim_create_augroup("winbar", {})
vim.api.nvim_create_autocmd({ "CursorMoved", "BufAdd", "BufNew", "WinScrolled" }, {
	callback = function()
		-- if the current file type is in the ignore ft table, then dont do anything
		if ignore_ft[vim.api.nvim_buf_get_option(0, "filetype")] ~= nil then
			return
		end
		-- print("Updating winbar")
		M.update()
	end,
})

--- updates a new winbar from information given by nvim-navic
M.update = function()
	if not navic.is_available() then
		vim.notify_once("Navic is not available", vim.log.levels.WARN, { timeout = 2000 })
	end

	-- vim.notify("Updating winbar", { timeout = 2000 })
	local location = navic.get_location() or " "
	vim.api.nvim_set_option_value("winbar", location, { scope = "local" })
end

-- NavicIconsFile
-- NavicIconsModule
-- NavicIconsNamespace
-- NavicIconsPackage
-- NavicIconsClass
-- NavicIconsMethod
-- NavicIconsProperty
-- NavicIconsField
-- NavicIconsConstructor
-- NavicIconsEnum
-- NavicIconsInterface
-- NavicIconsFunction
-- NavicIconsVariable
-- NavicIconsConstant
-- NavicIconsString
-- NavicIconsNumber
-- NavicIconsBoolean
-- NavicIconsArray
-- NavicIconsObject
-- NavicIconsKey
-- NavicIconsNull
-- NavicIconsEnumMember
-- NavicIconsStruct
-- NavicIconsEvent
-- NavicIconsOperator
-- NavicIconsTypeParameter
-- NavicText
-- NavicSeparator

return M
