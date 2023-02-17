local M = {}
--- Create autocmd to format on save
function M.format_on_save()
	-- client.resolved_capabilities.document_formatting = true
	vim.api.nvim_command("autocmd BufWritePre <buffer> :lua vim.lsp.buf.format() vim.cmd('write')")
	-- local group = vim.api.nvim_create_augroup("lsp_format_on_save", {})
	-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	-- group = group,
	-- callback = function()
	-- vim.lsp.buf.format()
	-- vim.cmd("write")
	-- end,
	-- buffer = 0,
	-- })
end

function M.on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- if client.server_capabilities.documentSymbolProvider then
	-- require("nvim-navic").attach(client, bufnr)
	-- end
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

	-- rename command
	vim.cmd("command! Rename :lua vim.lsp.buf.rename()")
	-- format command
	vim.cmd("command! Format :lua vim.lsp.buf.format() vim.cmd('write')")

	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set
	keymap("n", "gd", require("telescope.builtin").lsp_definitions, opts)
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gi", vim.lsp.buf.implementation, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "<F2>", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>h", vim.diagnostic.open_float, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
end

return M
