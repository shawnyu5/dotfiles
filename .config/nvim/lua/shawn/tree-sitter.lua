-- Disable Treesitter async parsing to reduce flickering until this issue is fixed: https://github.com/neovim/neovim/pull/33145
vim.g._ts_force_sync_parsing = true
local ts_langs = {
	"javascript",
	"go",
	"bash",
	"lua",
	"python",
	"cpp",
	"java",
	"typescript",
	"rust",
	"dockerfile",
	"markdown",
	"markdown_inline",
	"rst",
	"yaml",
	"tsx",
	"terraform",
	"json",
	"toml",
	"gitcommit",
	"git_rebase",
	"gitignore",
	"git_config",
	"diff",
}
require("nvim-treesitter").install(ts_langs)
vim.api.nvim_create_autocmd("FileType", {
	pattern = ts_langs,
	callback = function()
		vim.treesitter.start()
	end,
})

-- Register ansible.yaml as a YAML filetype
vim.treesitter.language.register("yaml", { "ansible.yaml" })
