--- get the current git branch name and return the string. Else returns "-"
local getGitBranch = function()
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
local get_harpoon_status = function()
	local mark_id = harpoon_mark.get_index_of(vim.fn.bufname())

	if not mark_id or mark_id == "" then
		return "No mark"
	end
	return "🦈 " .. mark_id
end

vim.g.lightline = {
	colorscheme = "tokyonight",
	active = {
		left = { { "mode", "paste" }, { "readonly", "filename", "modified" }, { "gitBranch" } },
		right = {
			{ "lineinfo" },
			{ "percent" },
			{ "fileformat", "fileencoding", "filetype" },
			{ "harpoonMark" },
		},
	},
	component = {
		gitBranch = getGitBranch(),
		-- harpoonMark = get_harpoon_status(),
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
