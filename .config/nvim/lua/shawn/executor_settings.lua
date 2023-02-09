-- reload this package
package.loaded["executor"] = nil

local ok, executor = pcall(require, "executor")
if not ok then
	vim.notify("executor not installed", vim.log.levels.WARN)
	return
end

local utils = require("shawn.utils")

local config = {
	commands = {
		cpp = {
			"make",
			"g++ % && ./a.out",
		},
		c = {
			"make",
			"g++ % && ./a.out",
		},
		python = {
			"python3 %",
		},
		javascript = {
			-- "npm start",
			"nodemon --delay 1 %",
		},
		typescript = {
			"npm start",
			"nodemon %",
			extern = true,
		},
		sh = {
			"bash %",
		},
		vim = {
			"source %",
			extern = false,
		},
		lua = {
			"luafile %",
			extern = false,
		},
		markdown = {
			-- "mdp %",
			"MarkdownPreview",
			-- "PeekToggle",
			extern = false,
		},
		java = {
			"make",
			"java %",
		},
		html = {
			"!google-chrome-stable %",
			extern = false,
		},
		go = {
			"go run .",
			"go test",
			extern = true,
		},
		rust = {
			"cargo run",
			"rustc % -o a.out && ./a.out",
		},
		dockerfile = {
			"docker build .",
		},
		cs = {
			"dotnet run",
			extern = true,
		},
	},
	default_mappings = true,
	always_exit = true,
	insert_on_enter = false, -- enter insert mode on entering a terminal
	dependency_commands = {
		make = "Makefile",
		["cargo run"] = " Cargo.toml",
		["npm start"] = "package.json",
	},
}

if utils.get_system_config().windows then
	for _, cmdTbl in pairs(config.commands) do
		cmdTbl["extern"] = false
		-- range for loop from 1 to 10
		for k, cmd in ipairs(cmdTbl) do
			cmdTbl[k] = string.format(
				"lua require('harpoon.term').sendCommand(1, '%s \\n') require('harpoon.term').gotoTerminal(1)",
				cmd
			)
		end
	end
end
-- print(vim.inspect(config.commands))

executor.setup(config)
