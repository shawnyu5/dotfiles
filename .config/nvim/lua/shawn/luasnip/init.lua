local ls = require("luasnip")
require("shawn.luasnip.snippets.go")

vim.keymap.set({ "i" }, "<C-s>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true })

-- vim.keymap.set({ "i", "s" }, "<C-E>", function()
--    if ls.choice_active() then
--       ls.change_choice(1)
--    end
-- end, { silent = true })

-- ls.setup()
