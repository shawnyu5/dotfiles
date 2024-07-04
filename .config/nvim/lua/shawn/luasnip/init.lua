local ls = require("luasnip")
require("luasnip.loaders.from_snipmate").load()
require("shawn.luasnip.snippets.go")
require("shawn.luasnip.snippets.gitcommit")
require("shawn.luasnip.snippets.make")
require("shawn.luasnip.snippets.yaml")
require("shawn.luasnip.snippets.markdown")

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
