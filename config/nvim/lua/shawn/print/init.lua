local M = {}

local opts = {
	cpp = {
		[[std::cout << "BBB" << '\n';]],
		'std::cout << BBB << "\n";',
	},
	lua = {
		'print("BBB")',
		"print(BBB)",
	},
	python = {
		'print("BBB")',
		"print(BBB)",
	},
	javascript = {
		'console.log("BBB")',
		"console.log(BBB)",
	},
	sh = {
		'echo "BBB"',
		"echo BBB",
	},
	vim = {
		'echo "BBB"',
		"echo BBB",
	},
	java = {
		[[System.out.println("BBB");]],
		[[System.out.println(BBB);]],
	},
}

function M.print(quotes)
	local filetype = vim.bo.filetype

	for k, v in pairs(opts) do
		if filetype == k then
			-- if quotes are wanted in print statement
			if quotes then
				vim.api.nvim_put({ v[1] }, "l", false, false)
				-- delete inside quotes
				vim.cmd('norm! ==_ci"')
				goto continue
			else
				vim.api.nvim_put({ v[2] }, "l", false, false)
				-- delete inside brackets
				vim.cmd("norm! ==_ci(")
				goto continue
			end
		end
	end
	-- if for loop is exited, then there are no mappings for current file type
	-- place `'p` as per usual
	vim.cmd("norm! i'p")
	do
		return
	end

	::continue::
	vim.cmd("norm! l")
	vim.api.nvim_command("startinsert")

	-- move curor to right and start insert mode
end

return M
