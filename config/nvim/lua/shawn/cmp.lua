vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Setup nvim-cmp.
local ok, cmp = pcall(require, "cmp")
if not ok then
   print("cmp not installed...")
   return
end

-- local lspkind = require "lspkind"
-- lspkind.init()

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "ultisnips" }, -- For ultisnips users.
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "buffer" },
		{
			name = "tmux",
			option = {
				all_panes = false,
				label = "[tmux]",
				trigger_characters = { "." },
				trigger_characters_ft = {}, -- { filetype = { '.' } }
			},
		},
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[Lsp]",
				nvim_lua = "[Lua]",
				ultisnips = "[Snippets]",
				buffer = "[Buffer]",
				path = "[Path]",
				tmux = "[Tmux]",
			})[entry.source.name]
			return vim_item
		end,
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- cmp.setup.cmdline(":", {
	-- sources = cmp.config.sources({
		-- { name = "path" },
	-- }, {
		-- { name = "cmdline", keyword_length = 5 },
	-- }),
-- })
