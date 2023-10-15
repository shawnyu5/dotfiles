local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
	command = " ~/.local/share/nvim/mason/bin/codelldb", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = vim.fn.expand("~") .. "/.local/share/nvim/mason/bin/OpenDebugAD7",
}

--- Looks at the cwd to see if there's an `a.out` present
---@return boolean true if `a.out` is found, false otherwise
local function find_a_out()
	local cwd = vim.fn.getcwd()
	local files = vim.system({ "ls", cwd }, { text = true }):wait()

   local a_out_pos = string.find(files.stdout, "a.out")
   if a_out_pos then
      return true
   end
   return false
end

print(find_a_out())

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			if find_a_out() then
            return vim.fn.getcwd() .. "/a.out"
         end

			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}
