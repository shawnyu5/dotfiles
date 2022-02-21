local ok, treesitter = pcall(require, "nvim-treesitter")
if not ok then
	print("treesitter not installed...")
	return
end
-- :TSInstall javascript bash lua python cpp vim
require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "html", "bash", "lua", "python", "cpp", "vim", "java", "typescript", "tsx" },
	highlight = {
		enable = true,
		-- disable ={ "html" },
		custom_captures = {
			-- Highlight the @foo.bar capture group with the "Identifier" highlight group.
			["foo.bar"] = "Identifier",
		},
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},
})
