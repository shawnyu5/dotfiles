-- reload this package
package.loaded["executor"] = nil

local ok, executor = pcall(require, "executor")
if not ok then
	print("executor not installed")
	return
end

executor.setup({
	commands = {
		cpp = {
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
         "tsc -w",
         extern = true
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
			"MarkdownPreview",
			extern = false,
		},
		java = {
			"make",
			"java %",
		},
		html = {
			"!chrome %",
			extern = false,
		},
	},
	default_mappings = true,
	always_exit = true,
	dependency_commands = {
		make = "makefile",
	},
})
