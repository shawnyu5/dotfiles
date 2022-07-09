local ok, autotag = pcall(require, "nvim-ts-autotag")
if not ok then
	vim.notify("nvim-ts-autotag not installed...", vim.log.ERROR)
	return
end
local filetypes = {
	"html",
	"javascript",
	"typescript",
	"javascriptreact",
	"typescriptreact",
	"svelte",
	"vue",
	"tsx",
	"jsx",
	"rescript",
	"xml",
	"php",
	"markdown",
	"glimmer",
	"handlebars",
	"hbs",
}
local skip_tags = {
	"area",
	"base",
	"br",
	"col",
	"command",
	"embed",
	"hr",
	"img",
	"slot",
	"input",
	"keygen",
	"link",
	"meta",
	"param",
	"source",
	"track",
	"wbr",
	"menuitem",
}

require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
	},
})
-- autotag.setup({
-- filetypes = filetypes,
-- })
