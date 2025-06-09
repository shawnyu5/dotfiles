require("shawn.lsp.java")
require("shawn.lsp.rust")

local utils = require("shawn.lsp.utils")
local lsp_utils = require("lspconfig.util")

local servers = {
	angularls = {
		on_attach = function(client, _)
			-- disable rename. Prefer tsserver's rename capabilities
			client.server_capabilities.rename = false
		end,
	},
	ansiblels = {
		root_markers = { "ansible.cfg", ".ansible-lint", "galaxy.yml", "galaxy.yaml" },
	},
	gradle_ls = {},
	basedpyright = {
		settings = {
			basedpyright = {
				analysis = {
					diagnosticMode = "workspace",
					inlayHints = {
						variableTypes = true,
						callArgumentNames = true,
						genericTypes = true,
					},
				},
			},
		},
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
	gh_actions_ls = {},
	yamlls = {
		on_attach = function(_, bufnr)
			utils.disable_formatting_on_save(bufnr)
		end,
		filetypes = {
			"yaml",
			"yaml.ansible",
		},
		capabilities = {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		},
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
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					-- Tell the language server which version of Lua you're using
					-- (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						-- Depending on the usage, you might want to add additional paths here.
						-- "${3rd}/luv/library",
						-- "${3rd}/busted/library",
					},
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
					-- library = vim.api.nvim_get_runtime_file("", true)
				},
			})
		end,
		settings = {
			Lua = {},
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
	graphql = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

vim.lsp.config("*", {
	capabilities = capabilities,
})

for server, config in pairs(servers) do
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end
