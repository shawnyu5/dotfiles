vim.api.nvim_create_augroup("formatOptions", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*",
	command = "setlocal formatoptions-=cro",
})

vim.api.nvim_create_augroup("makeFileIndent", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = "makeFileIndent",
	pattern = "make",
	command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4",
})

vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	group = "highlight_yank",
	pattern = "*",
	callback = function()
		require("vim.highlight").on_yank({ timeout = 104 })
	end,
})

vim.api.nvim_create_augroup("json_lsp", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = "json_lsp",
	pattern = "tsconfig.json",
	callback = function()
		vim.cmd("LspStop")
	end,
})

function OrgImports()
	print("OrgImports")
	local clients = vim.lsp.buf_get_clients()
	for _, client in pairs(clients) do
		local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
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

-- autocmd BufWritePre *.go lua OrgImports(1000)
local go_imports = vim.api.nvim_create_augroup("go_imports", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = go_imports,
	pattern = "*.go",
	callback = OrgImports,
})
