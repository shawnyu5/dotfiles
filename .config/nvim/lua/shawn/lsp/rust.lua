local ok, rt = pcall(require, "rust-tools")
 local utils = require("shawn.lsp.utils")
if not ok then
   vim.notify("rust-rools not installed...", vim.log.ERROR)
   return
end

rt.setup({
  server = {
    on_attach = function(client, bufnr)
       utils.on_attach(client, bufnr)
       utils.format_on_save()
       rt.inlay_hints.enable()

      -- Hover actions
      --vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      --vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- local lsp = require("lspconfig")
-- -- rust
-- lsp.rust_analyzer.setup({
	-- on_attach = function(client, bufnr)
		-- utils.on_attach(client, bufnr)
		-- utils.format_on_save()
	-- end,
-- })
