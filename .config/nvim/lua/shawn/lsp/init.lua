local notify = vim.notify
vim.notify = function(msg, ...)
	if
		msg:match("warning: multiple different client offset_encodings detected for buffer, this is not supported yet")
		or msg:find("server cancelled the request")
	then
		return
	end

	notify(msg, ...)
end

local utils = require("shawn.lsp.utils")
local lsp_utils = require("lspconfig.util")

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

local lspAugroup = vim.api.nvim_create_augroup("UserLspConfig", {})

vim.api.nvim_create_autocmd("LspAttach", {
	group = lspAugroup,
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		-- capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

		if vim.version().minor == 11 then
			vim.lsp.inlay_hint.enable(ev.bufnr, {})
		else
			vim.lsp.inlay_hint.enable(ev.bufnr, true)
		end

		vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

		local opts = { buffer = ev.buf }
		local keymap = vim.keymap.set
		keymap("n", "gd", require("telescope.builtin").lsp_definitions, opts)
		keymap("n", "gD", vim.lsp.buf.declaration, opts)
		keymap("n", "gi", vim.lsp.buf.implementation, opts)
		keymap("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor({ enter = true })
			if not winid then
				vim.lsp.buf.hover()
			end
		end, opts)
		keymap("n", "<F2>", vim.lsp.buf.code_action, opts)
		keymap("n", "<leader>h", vim.diagnostic.open_float, opts)
		keymap("n", "gr", require("telescope.builtin").lsp_references, opts)

		vim.api.nvim_buf_create_user_command(ev.buf, "Format", function()
			vim.lsp.buf.format({ async = false })
			vim.cmd("write")
		end, {})

		vim.api.nvim_buf_create_user_command(ev.buf, "Rename", function()
			vim.lsp.buf.rename()
		end, {})

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = ev.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = ev.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

local function lua_ls_runtime_path()
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")
	return runtime_path
end

local servers = {
	-- jdtls = {},
	angularls = {
		on_attach = function(client, _)
			-- disable rename. Prefer tsserver's rename capabilities
			client.server_capabilities.rename = false
		end,
	},
	gopls = {
		settings = {
			gopls = {
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
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
	},
	vuels = {},
	jsonls = {},
	marksman = {},
	csharp_ls = {},
	cssls = {},
	texlab = {},
	dockerls = {},
	yamlls = {
		on_attach = function(_, bufnr)
			utils.disable_formatting_on_save(bufnr)
		end,
	},
	clangd = {
		capabilities = {
			offsetEncoding = { "utf-16" },
		},
	},
	bashls = {},
	html = {
		on_attach = function(_, bufnr)
			utils.disable_formatting_on_save(bufnr)
		end,
		capabilities = {
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = true,
					},
				},
			},
		},
	},
	ts_ls = {
		on_attach = function(_, bufnr)
			utils.disable_formatting_on_save(bufnr)
		end,
	},
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = lua_ls_runtime_path(),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
	groovyls = {
		cmd = { "groovy-language-server" },
	},
	taplo = {},
	terraformls = {
		filetypes = {
			"terraform",
			"terrform-vars",
			"hcl",
		},
	},
	tflint = {
		root_dir = lsp_utils.root_pattern(".terraform", ".tflint.hcl"),
	},
}

-- for loop over all servers
for server, config in pairs(servers) do
	config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
	config.capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	require("lspconfig")[server].setup(config)
end

require("shawn.lsp.java")
require("shawn.lsp.rust")

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
