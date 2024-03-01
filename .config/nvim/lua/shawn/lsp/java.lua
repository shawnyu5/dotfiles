local jdtls_group = vim.api.nvim_create_augroup("jdtls", {})
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.java",
	group = jdtls_group,
	callback = function()
		local config = {
			cmd = { "jdtls" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
			on_attach = function(client, bufnr)
				local jdtls = require("jdtls")
				vim.notify("Java LSP on_attach")

				local command = vim.api.nvim_buf_create_user_command
				command(bufnr, "JdtExtractConstant", function()
					jdtls.extract_constant()
				end, { desc = "jdtls extract constant" })
				command(bufnr, "JdtExtractVariable", function()
					jdtls.extract_variable()
				end, { desc = "jdtls extract variable" })
				command(bufnr, "JdtExtractMethod", function()
					jdtls.extract_method()
				end, { desc = "jdtls extract a method" })
				command(bufnr, "JdtSuperImpl", function()
					jdtls.super_implementation()
				end, { desc = "jdtls jump to super implementation of method" })
			end,
		}
		require("jdtls").start_or_attach(config)
	end,
})

-- lsp.jdtls.setup({
-- on_attach = function(client, bufnr)
-- client.server_capabilities.document_formatting = false
-- client.server_capabilities.document_range_formatting = false
-- utils.on_attach(client, bufnr)
-- utils.format_on_save()
-- end,
-- handlers = {
-- ["$/progress"] = function(_, result)
-- vim.api.nvim_command(string.format(':echohl Function | echo "%s" | echohl None', result.message))
-- end,
-- },
-- })
