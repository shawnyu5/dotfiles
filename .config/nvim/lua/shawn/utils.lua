local M = {}

---@class System_config
---@field windows boolean if the current system is windows
---@field mkdp_browser_path string path to chrome executable
local system_config = {}

--- gets the system_config.json from ~/personal/
---@return table System_config representation of system_config.json
function M.get_system_config()
	local lines = {}
	for line in io.lines(vim.fn.expand("~") .. "/personal/system_config.json") do
		lines[#lines + 1] = line
	end

	return vim.fn.json_decode(lines)
end

return M
