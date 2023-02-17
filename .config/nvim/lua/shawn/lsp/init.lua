local ok, lsp = pcall(require, "lspconfig")
if not ok then
	vim.notify("lsp config not installed...", vim.log.levels.WARN)
	return
end

local utils = require("shawn.lsp.utils")

-- LSP Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	update_in_insert = true,
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
-- config.on_attach = function(client, bufnr)
-- vim.api.nvim_create_user_command("Test", function()
-- print("hello world")
-- end, {})
-- vim.notify("Java LSP on_attach")
-- utils.on_attach(client, bufnr)
-- utils.format_on_save()
-- end
-- vim.pretty_print(config.on_attach)

local jdtls_group = vim.api.nvim_create_augroup("jdtls", {})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.java",
	group = jdtls_group,
	callback = function()
		local config = {
			cmd = { "jdtls" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
			on_attach = function(client, bufnr)
				local jdtls = require("jdtls")
				vim.notify("Java LSP on_attach")
				utils.on_attach(client, bufnr)
				utils.format_on_save()

				local command = vim.api.nvim_buf_create_user_command
				command(bufnr, "JdtExtractConstant", function()
					jdtls.extract_constant()
				end, { desc = "jdtls extract constant" })
				command(bufnr, "JdtExtractVariable", function()
					jdtls.extract_variable()
				end, { desc = "jdtls extract variable" })
				command(bufnr, "JdtExtractMethod", function()
					jdtls.extract_method()
				end, { desc = "jdtls extract a method" })
				command(bufnr, "JdtSuperImpl", function()
					jdtls.super_implementation()
				end, { desc = "jdtls jump to super implementation of method" })
			end,
		}
		require("jdtls").start_or_attach(config)
	end,
})

-- lsp.jdtls.setup({
-- on_attach = function(client, bufnr)
-- client.server_capabilities.document_formatting = false
-- client.server_capabilities.document_range_formatting = false
-- utils.on_attach(client, bufnr)
-- utils.format_on_save()
-- end,
-- handlers = {
-- ["$/progress"] = function(_, result)
-- vim.api.nvim_command(string.format(':echohl Function | echo "%s" | echohl None', result.message))
-- end,
-- },
-- })

-- angular
lsp.angularls.setup({
	on_attach = function(client, bufnr)
		-- disable rename
		client.server_capabilities.rename = false
	end,
})

-- vue
lsp.vuels.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- json
lsp.jsonls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- markdown
lsp.marksman.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = "*.md",
	callback = function()
		vim.defer_fn(function()
			vim.notify("Restarted marksman lsp...")
			vim.cmd("LspStart")
		end, 7000)
	end,
	once = true,
})

-- c#
lsp.csharp_ls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- lsp.omnisharp.setup({
-- cmd = { "dotnet", "/usr/lib/omnisharp-roslyn/OmniSharp.dll" },
-- on_attach = function(client, bufnr)
-- utils.on_attach(client, bufnr)
-- client.server_capabilities.semanticTokensProvider = nil
-- end,

-- -- Enables support for reading code style, naming convention and analyzer
-- -- settings from .editorconfig.
-- enable_editorconfig_support = true,

-- -- If true, MSBuild project system will only load projects for files that
-- -- were opened in the editor. This setting is useful for big C# codebases
-- -- and allows for faster initialization of code navigation features only
-- -- for projects that are relevant to code that is being edited. With this
-- -- setting enabled OmniSharp may load fewer projects and may thus display
-- -- incomplete reference lists for symbols.
-- enable_ms_build_load_projects_on_demand = false,

-- -- Enables support for roslyn analyzers, code fixes and rulesets.
-- enable_roslyn_analyzers = false,

-- -- Specifies whether 'using' directives should be grouped and sorted during
-- -- document formatting.
-- organize_imports_on_format = false,

-- -- Enables support for showing unimported types and unimported extension
-- -- methods in completion lists. When committed, the appropriate using
-- -- directive will be added at the top of the current file. This option can
-- -- have a negative impact on initial completion responsiveness,
-- -- particularly for the first few completion sessions after opening a
-- -- solution.
-- enable_import_completion = false,

-- -- Specifies whether to include preview versions of the .NET SDK when
-- -- determining which version to use for project loading.
-- sdk_include_prereleases = true,

-- -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
-- -- true
-- analyze_open_documents_only = false,
-- })
-- css
lsp.cssls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- latex
lsp.texlab.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

-- docker
lsp.dockerls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		utils.format_on_save()
	end,
})

lsp.yamlls.setup({
	on_attach = function(client, bufnr)
		utils.on_attach(client, bufnr)
		-- utils.format_on_save()
		require("nvim-navic").attach(client, bufnr)
	end,
})

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
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
		},
	},
	init_options = {
		usePlaceholders = false,
	},
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

lsp.lua_ls.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.document_formatting = false

		-- client.server_capabilities.document_range_formatting = true
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
