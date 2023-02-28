--- get the current git branch name
---@return string the git branch. If not git branch, return "-"
vim.g.GetGitBranch = function()
	local f = io.popen("git rev-parse --abbrev-ref HEAD 2> /dev/null")
	if f then
		-- read output of current line
		local branch = f:read("*l")
		f:close()
		if branch then
			return tostring(branch)
		else
			return ""
		end
	end
end
local harpoon_mark = require("harpoon.mark")

--- return the current harpoon mark if it exists
---@return string the harpoon mark for the statusline
vim.g.Get_harpoon_status = function()
	local mark_id = harpoon_mark.get_index_of(vim.fn.bufname())

	if not mark_id or mark_id == "" then
		return ""
	end
	return "🦈 " .. mark_id
end

--- check if `spell` is enabled
---@return string
vim.g.Check_spell = function()
	if vim.opt.spell:get() then
		return "📚"
	end
	return ""
end

--- Get the relative path name of the current file
---@return string
vim.g.Get_relative_path_name = function()
	return vim.fn.expand("%f")
end

local lightline_component = {
	mode = "%{lightline#mode()}",
	absolutepath = "%F",
	relativepath = "%f",
	filename = "%f",
	modified = "%M",
	bufnum = "%n",
	paste = '%{&paste?"PASTE":""}',
	readonly = "%R",
	charvalue = "%b",
	charvaluehex = "%B",
	fileencoding = '%{&fenc!=#""?&fenc:&enc}',
	fileformat = "%{&ff}",
	filetype = '%{&ft!=#""?&ft:"no ft"}',
	percent = "%3p%%",
	percentwin = "%P",
	spell = '%{&spell?&spelllang:""}',
	lineinfo = "%3l:%-2c",
	line = "%l",
	column = "%c",
	close = "%999X X ",
	winnr = "%{winnr()}",
}

vim.g.lightline = {
	colorscheme = "tokyonight",
	component_expand = {
		relativePath = lightline_component.relativepath,
	},
	active = {
		left = {
			{ "mode", "paste" },
			{ "readonly", "filename", "modified" },
			{ "gitBranch" },
			{ "harpoonMark" },
		},
		right = {
			{ "lineinfo" },
			{ "percent" },
			{ "fileformat", "fileencoding", "filetype", "checkSpell" },
		},
	},
	tab_component_function = {
		relativepathFunc = "Get_relative_path_name",
	},
	tab = {
		active = { "tabnum", "filename", "modified" },
		inactive = { "tabnum", "filename", "modified" },
	},
	tabline = {
		left = {
			{ "tabs" },
		},
		right = {
			-- { "close" },
		},
	},
	component_function = {
		gitBranch = "GetGitBranch",
		harpoonMark = "Get_harpoon_status",
		relativePathName = "Get_relative_path_name",
		checkSpell = "Check_spell",
	},
}

-- local harpoonGroup = vim.api.nvim_create_augroup("HarpoonGroup", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufLeave" }, {
-- group = harpoonGroup,
-- pattern = "*",
-- callback = function()
-- print("reloading...")
-- local mark_id = harpoon_mark.get_index_of(vim.fn.bufname())
-- if not mark_id or mark_id == "" then
-- return
-- end
-- -- return "🦈 " .. mark_id

-- vim.tbl_extend("force", vim.g.lightline, {
-- component = {
-- harpoonMark = "🦈 " .. mark_id,
-- },
-- })
-- -- vim.g.lightline.component.harpoonMark = "hello"
-- -- vim.g.lightline.component.harpoonMark = "🦈 " .. mark_id
-- print("reloaded")
-- print("🦈" .. mark_id)
-- print("function vim.g.lightline.component.harpoonMark:", vim.inspect(vim.g.lightline.component.harpoonMark)) -- __AUTO_GENERATED_PRINT_VAR__
-- -- vim.cmd.redrawstatus()
-- end,
-- })

-- vim.g.lightline.component_function_visible_condition = {
-- gitBranch = function()
-- return getGitBranch() ~= "-"
-- end,
-- }
