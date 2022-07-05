local ok, navic = pcall(require, "nvim-navic")
if not ok then
	vim.notify("nvim-navic not installed...", vim.log.ERROR)
	return
end

local M = {}
--
-- determine weather to enable format on save
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

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	if client.name ~= "dockerls" then
		navic.attach(client, bufnr)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

	-- Mappings
	local opts = {
		noremap = true,
		silent = true,
	}

	-- require("lsp_signature").on_attach()

	-- rename command
	vim.cmd("command! Rename :lua vim.lsp.buf.rename()")
	-- format command
	vim.cmd("command! Format :lua vim.lsp.buf.format() vim.cmd('write')")

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
	buf_set_keymap("n", "H", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>h", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
end

return M
