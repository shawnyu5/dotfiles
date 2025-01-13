vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 1000 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 1000
vim.o.foldenable = false
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

require("ufo").setup({
	close_fold_kinds_for_ft = {
		default = { "imports" },
	},
})
