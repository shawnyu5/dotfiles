local M = {}

---@enum system_names
M.system_names = {
	work_laptop = "work_laptop",
	linux = "linux",
	hp_laptop = "hp_laptop",
}
---@class System_config
---@field windows boolean if the current system is windows @deprecated use `system_name` instead, for more flexibility
---@field mkdp_browser_path string path to chrome executable
---@field system_name system_names the system name.
local system_config = {}

--- gets the `system_config.json` from ~/personal/
---@return System_config table Representation of system_config.json
function M.get_system_config()
	local lines = {}
	for line in io.lines(vim.fn.expand("~") .. "/personal/system_config.json") do
		lines[#lines + 1] = line
	end

	return vim.fn.json_decode(lines)
end

---@return boolean windows if the current system is windows or not
---@deprecated
function M.is_windows()
	local sys_config = M.get_system_config()
	return sys_config.windows
end

return M
