local status, null_ls = pcall(require, "null-ls")
if not status then
	vim.notify("null-ls not installed...", vim.log.levels.WARN)
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua,
		-- diagnostics.ansiblelint,
		-- formatting.prettier.with({
		-- extra_args = {
		-- "--tab-width 3",
		-- "--double-quotes",
		-- },
		-- disabled_filetypes = { "html" },
		-- }),
		-- formatting.eslint,
		-- formatting.black.with({ extra_args = { "--fast" } }),
		formatting.clang_format.with({
			disabled_filetypes = { "java" },
		}),
		formatting.google_java_format,
		formatting.ocamlformat,
		-- formatting.markdownlint,
		-- formatting.markdownlint,
		formatting.prettierd.with({
			disabled_filetypes = { "json" },
		}),
		diagnostics.hadolint,
		diagnostics.gitlint,
		-- TODO: idk why null-ls cant find this executable. It is installed by mason...
		-- diagnostics.yamllint,
		diagnostics.actionlint.with({
			extra_args = { "-shellcheck=" },
		}),
	},
})
