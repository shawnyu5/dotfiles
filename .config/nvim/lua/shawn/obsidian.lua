---@module 'obsidian'
---@type obsidian.config
require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{
			name = "obsidian",
			path = "~/obsidian/",
		},
	},
	picker = {
		name = "snacks.picker",
	},
	callbacks = {
		enter_note = function()
			local buf = vim.api.nvim_get_current_buf()
			if vim.b[buf].obsidian_maps_set then
				return
			end

			vim.notify("Creating Obsidian notes key maps")
			-- Get the buffer number of the note we just walked into
			local buf = vim.api.nvim_get_current_buf()
			local key_opts = { buffer = buf, remap = false }

			-- key_opts.desc = "Obsidian: Search Titles & Aliases"
			-- vim.keymap.set("n", "<leader>ff", "<cmd>Obsidian quick_switch<CR>", key_opts)

			key_opts.desc = "Obsidian: Live Grep Text Content"
			vim.keymap.set("n", "<leader>fg", "<cmd>Obsidian search<CR>", key_opts)

			key_opts.desc = "Obsidian: Open in editor"
			vim.keymap.set("n", "<leader>m", "<cmd>Obsidian open<CR>", key_opts)

			vim.b[buf].obsidian_maps_set = true
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKillMarksmanInObsidianVault", { clear = true }),
	callback = function(args)
		local bufnr = args.buf
		local incoming_client = vim.lsp.get_client_by_id(args.data.client_id)
		if not incoming_client then
			return
		end

		local function logMarksmanShutdown()
			vim.notify("Marksman LSP shutdown in Obsidian vault")
		end

		-- 1. Marksman just attached. If Obsidian is already here, kill Marksman immediately.
		if incoming_client.name == "marksman" then
			local obsidian_active = #vim.lsp.get_clients({ bufnr = bufnr, name = "obsidian-ls" }) > 0
			if obsidian_active then
				vim.lsp.buf_detach_client(bufnr, incoming_client.id)
				logMarksmanShutdown()
			end

		-- 2. Obsidian just attached. If Marksman is already running here, terminate it.
		elseif incoming_client.name == "obsidian-ls" then
			local active_marksman_clients = vim.lsp.get_clients({ bufnr = bufnr, name = "marksman" })
			for _, marksman_client in ipairs(active_marksman_clients) do
				vim.lsp.buf_detach_client(bufnr, marksman_client.id)
				logMarksmanShutdown()
			end
		end
	end,
})
