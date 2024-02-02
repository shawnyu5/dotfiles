local utils = require("shawn.lsp.utils")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
vim.g.rustaceanvim = {
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			utils.on_attach(client, bufnr)
			utils.format_on_save(bufnr)
			vim.keymap.set("n", "<F2>", function()
				vim.cmd.RustLsp("codeAction")
			end, { noremap = true, silent = true, buffer = bufnr })
		end,
	},
}

-- rt.setup({
--    -- settings = {
--    -- ["rust-analyzer"] = {
--    -- cargo = {
--    -- allFeatures = true,
--    -- },
--    -- },
--    -- },
--    capabilities = capabilities,
--    server = {
--       on_attach = function(client, bufnr)
--          utils.on_attach(client, bufnr)
--          utils.format_on_save(bufnr)
--          rt.inlay_hints.enable()

--          -- Hover actions
--          --vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--          -- Code action groups
--          --vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--       end,
--    },
-- })

-- -- local lsp = require("lspconfig")
-- -- -- rust
-- -- lsp.rust_analyzer.setup({
-- -- on_attach = function(client, bufnr)
-- -- utils.on_attach(client, bufnr)
-- -- utils.format_on_save()
-- -- end,
-- -- })
