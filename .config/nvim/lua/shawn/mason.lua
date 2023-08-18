local ok, mason = pcall(require, "mason")
if not ok then
	vim.notify("mason not installed...", vim.log.ERROR)
	return
end

local ensure_installed = {
	"bash-language-server",
	"clangd",
	"clang-format",
	"csharp-language-server",
	"docker-compose-language-service",
	"dockerfile-language-server",
	"gitlint",
	"gopls",
	"html-lsp",
	"marksman",
   "prettierd",
   "angular-language-server",
   "jdtls",
   "json-lsp",
   "css-lsp",
   "yaml-language-server",
   "rust-analyzer",
   "typescript-language-server",
   "lua-language-server",
   "yamllint",
   "taplo"
}

mason.setup()
require("mason-lspconfig").setup()

local mr = require("mason-registry")
for _, tool in ipairs(ensure_installed) do
	local p = mr.get_package(tool)
	if not p:is_installed() then
		p:install()
	end
end
