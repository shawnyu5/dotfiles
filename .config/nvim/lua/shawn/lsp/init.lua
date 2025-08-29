local notify = vim.notify
vim.notify = function(msg, ...)
	if msg == nil then
		return
	end

	if
		msg:match("warning: multiple different client offset_encodings detected for buffer, this is not supported yet")
		or msg:find("server cancelled the request")
	then
		return
	end

	notify(msg, ...)
end

require("shawn.lsp.servers")

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
		vim.diagnostic.config({ virtual_text = true })
		if vim.version().minor == 11 then
			vim.lsp.inlay_hint.enable(ev.bufnr, {})
		elseif vim.version().minor == 12 then
			vim.lsp.inlay_hint.enable(true, {
				bufnr = ev.bufnr,
			})
		end

		-- vim.lsp.inline_completion.enable(not vim.lsp.inline_completion.is_enabled())
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
