local ok, neotest = pcall(require, "neotest")
if not ok then
	vim.notify("neotest not installed...", vim.log.ERROR)
	return
end

neotest.setup({
	adapters = {
		require("neotest-plenary"),
		require("neotest-jest")({
			jestCommand = "npm test --",
			jestConfigFile = "jest.config.ts",
			env = { CI = true },
		}),
		require("neotest-go"),
	},
})

local key_maps = {
	{
		"<leader>tf",
		function()
			neotest.run.run(vim.fn.expand("%"))
			neotest.output.open({ enter = true })
		end,
		{ desc = "Run tests for current file" },
	},
	{
		"<leader>tn",
		function()
			neotest.run.run()
			neotest.output.open({ enter = true })
		end,
		{ desc = "Run the nearest test" },
	},
}
for _, v in ipairs(key_maps) do
	vim.keymap.set("n", v[1], v[2], v[3])
end

local descriptions = function()
	local t = {}
	for _, v in ipairs(key_maps) do
		table.insert(t, v[3].desc)
	end
	return t
end

vim.keymap.set("n", "<leader>tt", function()
	vim.ui.select(descriptions(), { prompt = "Select testing options:" }, function(selected)
		for _, v in ipairs(key_maps) do
			-- find the keymap that matches the selected description
			if selected == v[3].desc then
				-- run the lua function
				v[2]()
			end
		end
	end)
end, { noremap = true })
