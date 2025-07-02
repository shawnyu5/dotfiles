require("conform").setup({
   format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
         vim.notify("[Conform] Autoformatting is disabled for this buffer", vim.log.levels.WARN)
         return
      end
      return { timeout_ms = 500, lsp_fallback = true }
   end,

   formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff" },
      yaml = { "yamlfmt", "prettierd" },
      ["yaml.ansible"] = { "yamlfmt", "prettierd" },
      -- Use a sub-list to run only the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
   },
})
