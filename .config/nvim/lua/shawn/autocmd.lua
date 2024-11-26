local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd
create_augroup("formatOptions", { clear = true })
create_autocmd({ "BufEnter" }, {
	pattern = "*",
	command = "setlocal formatoptions-=cro",
})

create_augroup("makeFileIndent", { clear = true })
create_autocmd({ "BufEnter" }, {
	group = "makeFileIndent",
	pattern = "make",
	command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4",
})

create_augroup("highlight_yank", { clear = true })

local utils = require("shawn.utils")
if utils.get_system_config().system_name == utils.system_names.work_laptop then
	create_autocmd({ "TextYankPost" }, {
		group = "highlight_yank",
		pattern = "*",
		callback = function()
			require("vim.highlight").on_yank({ timeout = 104 })
		end,
	})
else
	create_autocmd({ "TextYankPost" }, {
		group = "highlight_yank",
		pattern = "*",
		callback = function()
			require("vim.hl").on_yank({ timeout = 104 })
		end,
	})
end

create_augroup("json_lsp", { clear = true })
create_autocmd({ "BufEnter" }, {
	group = "json_lsp",
	pattern = "tsconfig.json",
	callback = function()
		vim.cmd("LspStop")
	end,
})

function OrgImports()
	local clients = vim.lsp.buf_get_clients()
	for _, client in pairs(clients) do
		local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
				else
					vim.lsp.buf.execute_command(r.command)
				end
			end
		end
	end
end

local go_imports = create_augroup("go_imports", { clear = true })
create_autocmd({ "BufWritePre" }, {
	group = go_imports,
	pattern = "*.go",
	callback = OrgImports,
})

local termina_auto_group = create_augroup("terminal_auto_group", { clear = true })
create_autocmd({ "TermOpen" }, {
	group = termina_auto_group,
	callback = function()
		vim.cmd("setlocal nospell")
	end,
})

vim.filetype.add({
	extension = {
		vugu = "html",
	},
})

-- local central_ci_augroup = create_augroup("central_ci", {})
-- create_autocmd({ "BufEnter" }, {
-- group = central_ci_augroup,
-- pattern = vim.fn.expand("~") .. "/central-ci/*",
-- callback = function()
-- if vim.opt_local.modifiable:get() == true then
-- vim.cmd("set ff=unix")
-- vim.cmd("wa")
-- end
-- end,
-- })

local terminal_group = create_augroup("terminal", {})
create_autocmd({ "TermOpen" }, {
	group = terminal_group,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})
