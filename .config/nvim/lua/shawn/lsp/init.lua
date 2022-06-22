local ok, lsp = pcall(require, "lspconfig")
if not ok then
	print("lsp config not installed...")
	return
end

local utils = require("shawn.lsp.utils")

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		prefix = "●",
	},
	severity_sort = true,
	signs = true,
})

local signs = {
	Error = "E ",
	Warning = "W ",
	Hint = "H ",
	Information = "I ",
}

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, {
		text = icon,
		texthl = hl,
		numhl = "",
	})
end

-- java
lsp.jdtls.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- angluar
lsp.angularls.setup({
	on_attach = function(client, bufnr)
		-- disable rename
		client.server_capabilities.rename = false
	end,
})

-- json
lsp.jsonls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- css
lsp.cssls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- markdown
-- lsp.remark_ls.setup({
-- on_attach = function(client, bufnr)
-- client.server_capabilities.document_formatting = false,
-- on_attach(client, bufnr)
-- end,
-- })

-- docker
-- lsp.dockerls.setup({})

-- rust
lsp.rust_analyzer.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- go
lsp.gopls.setup({
	on_attach = function(client, bufnr)
		utils.format_on_save()
		utils.on_attach(client, bufnr)
	end,
})

-- clangd
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
lsp.clangd.setup({
	capabilities = capabilities,
	filetypes = { "c", "cpp", "objc", "objcpp" },
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		utils.format_on_save()
		utils.on_attach(client, bufnr)
	end,
})

-- bashls
lsp.bashls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
	end,
})

--Enable (broadcasting) snippet capability for completion
local capabilities_html = vim.lsp.protocol.make_client_capabilities()
capabilities_html.textDocument.completion.completionItem.snippetSupport = true

-- html set up
lsp.html.setup({
	capabilities = capabilities_html,
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		utils.format_on_save()
		utils.on_attach(client, bufnr)
	end,
})

-- tsserver
lsp.tsserver.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
		utils.format_on_save()
		utils.on_attach(client, bufnr)
	end,
})

-- sumneko lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp.sumneko_lua.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false

		-- client.server_capabilities.document_range_formatting = true
		utils.format_on_save()
		utils.on_attach(client, bufnr)
	end,
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
lsp.pyright.setup({
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		-- utils.format_on_save()
	end,
})

-- color settings
vim.cmd([[
    " error
    hi DiagnosticError guifg=BrightRed gui=bold,underline
    " hi DiagnosticUnderlineError guifg=red gui=bold,underline
    hi DiagnosticFloatingError guifg=red

    " warning
    " hi DiagnosticWarn guifg=orange gui=italic,underline
    hi DiagnosticVirtualTextWarn guifg=orange
    " hi DiagnosticUnderlineWarn guifg=orange gui=italic,underline


    " info
    hi DiagnosticInfo guifg=NONE
    hi DiagnosticVirtualTextInfo guifg=white
    hi DiagnosticVirtualTextInfo guifg=NONE
    hi DiagnosticSignInfor guifg=NONE

   hi DiagnosticUnderlineInfo guifg=NONE

    " hint
    hi DiagnosticHint guifg=orange, gui=italic
    hi DiagnosticVirtualTextHint guifg=orange guibg=NONE
    hi DiagnosticUnderlineHint guifg=orange
    hi DiagnosticFloatingHint guifg=orange
]])
