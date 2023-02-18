local ok, lsp = pcall(require, "lspconfig")
if not ok then
	vim.notify("lsp config not installed...", vim.log.levels.WARN)
	return
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

require("shawn.lsp.java")
require("shawn.lsp.angular")
require("shawn.lsp.vue")
require("shawn.lsp.json")
require("shawn.lsp.markdown")
require("shawn.lsp.c_sharp")
require("shawn.lsp.css")
require("shawn.lsp.latex")
require("shawn.lsp.docker")
require("shawn.lsp.yaml")
require("shawn.lsp.rust")
require("shawn.lsp.go")
require("shawn.lsp.cpp")
require("shawn.lsp.bash")
require("shawn.lsp.html")
require("shawn.lsp.ts")
require("shawn.lsp.lua")
require("shawn.lsp.python")

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
