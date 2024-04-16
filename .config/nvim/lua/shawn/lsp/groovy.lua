local lsp = require("lspconfig")
lsp.groovyls.setup({
	cmd = { "groovy-language-server" },
})
