local ls = require("luasnip")
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load({ paths = "./lua/shawn/luasnip/snippets" })
require("shawn.luasnip.snippets.gitcommit")

vim.keymap.set({ "i" }, "<C-s>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	ls.jump(-1)
end, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
--    if ls.choice_active() then
--       ls.change_choice(1)
--    end
-- end, { silent = true })

-- ls.setup()
