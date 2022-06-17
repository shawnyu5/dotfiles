local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/usr/bin/debugAdapters/bin/OpenDebugAD7",
}

-- refer to the docs for more information
-- https://code.visualstudio.com/docs/cpp/launch-json-reference
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
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
-- dap.configurations.cpp = {
-- {
-- name = "Launch",
-- type = "lldb",
-- request = "launch",
-- program = function()
-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
-- end,
-- cwd = "${workspaceFolder}",
-- stopOnEntry = true,
-- args = {},

-- -- 💀
-- -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
-- --
-- --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
-- --
-- -- Otherwise you might get the following error:
-- --
-- --    Error on launch: Failed to attach to the target process
-- --
-- -- But you should be aware of the implications:
-- -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
-- -- runInTerminal = false,
-- },
-- }

-- -- If you want to use this for Rust and C, add something like this:

-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
