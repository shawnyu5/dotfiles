local conform = require("conform")
conform.setup({
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			vim.notify("[Conform] Autoformatting is disabled for this buffer", vim.log.levels.WARN)
			return
		end
		return {
			timeout_ms = 500,
			lsp_fallback = true,
			filter = function(client)
				return client.name ~= "ts_ls"
			end,
		}
	end,

	formatters = {
		prettier = {
			args = { "--embedded-language-formatting", "off" },
		},
		prettierd = {
			args = { "--embedded-language-formatting", "off" },
		},
	},
	formatters_by_ft = {
		markdown = { "prettierd" },
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "ruff" },
		yaml = { "yamlfmt", "prettierd" },
		["yaml.ansible"] = { "yamlfmt", "prettierd" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		swift = { "swiftformat" },
		terraform = { "tflint" },
	},
})

conform.formatters.swiftformat = {
	append_args = function()
		return { "--disable", "unusedArguments" }
	end,
}
