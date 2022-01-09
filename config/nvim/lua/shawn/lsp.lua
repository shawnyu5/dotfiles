local lsp = require("lspconfig")

-- determine weather to enable auto formatting
local format_on_save = function(client)
	-- client.resolved_capabilities.document_formatting = true
	vim.api.nvim_command("autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync() vim.cmd('write')")
end

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

	-- Mappings
	local opts = {
		noremap = true,
		silent = true,
	}

	require("lsp_signature").on_attach()

	-- rename command
	vim.cmd("command! Rename :lua vim.lsp.buf.rename()")
	-- format command
	vim.cmd("command! Format :lua vim.lsp.buf.formatting_sync() vim.cmd('write')")

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gd", '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
	buf_set_keymap("n", "H", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>h", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- show line diagnostics instead of virtual text
	-- vim.api.nvim_command("autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()({ focusable = false })")
end

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = true,
	virtual_text = {
		spacing = 4,
		prefix = "●",
	},
	severity_sort = true,
	signs = false,
})

local signs = {
	Error = " ",
	Warning = " ",
	Hint = " ",
	Information = " ",
}

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = "",
	})
end

-- ccls set up
-- unable to build ccls successfully
-- lsp.ccls.setup{
-- on_attach = on_attach
-- }

-- TODO: set up java
-- java
-- require("lspconfig").java_language_server.setup({
-- cmd = { "/usr/local/bin/lang_server_linux.sh" },
-- })
-- installation link
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jdtls
require("lspconfig").jdtls.setup({})

-- clangd
lsp.clangd.setup({
	filetypes = { "c", "cpp", "objc", "objcpp" },
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		format_on_save(client)
		on_attach(client, bufnr)
	end,
})

-- bashls
lsp.bashls.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end,
})

-- html
--Enable (broadcasting) snippet capability for completion
local capabilities_html = vim.lsp.protocol.make_client_capabilities()
capabilities_html.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").html.setup({
	capabilities = capabilities_html,
	on_attach = function(client, bufnr)
		-- auto_format(client)
		on_attach(client, bufnr)
	end,
})

-- tsserver
lsp.tsserver.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		on_attach(client, bufnr)
	end,
	-- on_attach = on_attach,
	-- on_attach.client.resolved_capabilities.document_formatting = false,
	-- resolved_capabilities.document_range_formatting = false
})

-- sumneko lua
-- local system_name
if vim.fn.has("mac") == 1 then
	-- system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
	-- system_name = "Linux"
elseif vim.fn.has("win32") == 1 then
	-- system_name = "Windows"
else
	print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local home_dir = vim.fn.expand("~")
local sumneko_root_path = home_dir .. "/.local/share/nvim/lsp_servers/lua-language-server/" -- require access to main.lua in root directory
local sumneko_binary = sumneko_root_path .. "bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp.sumneko_lua.setup({
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		on_attach(client, bufnr)
	end,
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "main.lua" },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- pyright
-- npm install -g pyright
-- pyright is pretty primitive...
require("lspconfig").pyright.setup({
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end,
})

-- color settings
vim.cmd([[
    " error
    hi DiagnosticError guifg=BrightRed gui=bold,underline
    hi DiagnosticUnderlineError guifg=red gui=bold,underline
    hi DiagnosticFloatingError guifg=red

    " warning
    hi DiagnosticWarn guifg=orange gui=italic,underline
    hi DiagnosticVirtualTextWarn guifg=orange
    hi DiagnosticUnderlineWarn guifg=orange gui=italic,underline


    " info
    hi DiagnosticInfo guifg=NONE
    " hi DiagnosticVirtualTextInfo guifg=white
    hi DiagnosticVirtualTextInfo guifg=NONE
    hi DiagnosticSignInfor guifg=NONE

   hi DiagnosticUnderlineInfo guifg=NONE

    " hint
    hi DiagnosticHint guifg=orange, gui=italic
    hi DiagnosticVirtualTextHint guifg=orange guibg=NONE
    hi DiagnosticUnderlineHint guifg=orange
    hi DiagnosticFloatingHint guifg=orange

]])
