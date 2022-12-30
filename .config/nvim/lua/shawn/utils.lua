local M = {}

--- gets the system_config.json from ~/personal/
---@return table json representation of system_config.json
function M.get_system_config()
	local lines = {}
	for line in io.lines(vim.fn.expand("~") .. "/personal/system_config.json") do
		lines[#lines + 1] = line
	end

	---@type table
	return vim.fn.json_decode(lines)
end

return M
