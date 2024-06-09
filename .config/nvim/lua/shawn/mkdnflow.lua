local ok, mkdnflow = pcall(require, "mkdnflow")
if not ok then
	vim.notify("mkdnflow not installed...", vim.log.ERROR)
	return
end

mkdnflow.setup({
	modules = {
		bib = true,
		buffers = true,
		conceal = true,
		cursor = true,
		folds = true,
		links = true,
		lists = true,
		maps = true,
		paths = true,
		tables = true,
	},
	perspective = {
		priority = "first",
		fallback = "current",
		-- dont use a file name to serve as root dir
		root_tell = false,
		-- dont change cwd
		nvim_wd_heel = false,
	},
	links = {
		style = "markdown",
		name_is_source = false,
		conceal = false,
		implicit_extension = nil,
		transform_implicit = false,
		transform_explicit = function(text)
			text = text:gsub(" ", "-")
			text = text:lower()
			text = os.date("%Y-%m-%d_") .. text
			return text
		end,
	},
	to_do = {
		symbols = { " ", "x" },
		update_parents = true,
		not_started = " ",
		complete = "x",
	},
	tables = {
		-- let the lsp handle formatting
		trim_whitespace = false,
		format_on_move = false,
		auto_extend_rows = false,
		auto_extend_cols = false,
	},
	mappings = {
		-- dont make links from text when pressing enter
		MkdnEnter = false,
		MkdnTab = false,
		MkdnSTab = false,
		-- dont need to jump to next / prev link in file
		MkdnNextLink = false,
		MkdnPrevLink = false,
		MkdnNextHeading = { "n", "]]" },
		MkdnPrevHeading = { "n", "[[" },
		-- <C-O> / <C-I> are better for this
		MkdnGoBack = false,
		MkdnGoForward = false,
		MkdnFollowLink = false,
		MkdnDestroyLink = { "n", "<M-CR>" },
		MkdnTagSpan = { "v", "<M-CR>" },
		MkdnMoveSource = false,
		-- do not override `ya` in normal mode
		MkdnYankAnchorLink = false,
		-- dont overide y* mappings
		MkdnYankFileAnchorLink = false,
		MkdnIncreaseHeading = { "n", "+" },
		MkdnDecreaseHeading = false,
		MkdnToggleToDo = { { "n", "v" }, "<C-Space>" },
		MkdnNewListItem = false,
		MkdnNewListItemBelowInsert = { "n", "o" },
		MkdnNewListItemAboveInsert = { "n", "O" },
		MkdnExtendList = false,
		MkdnUpdateNumbering = false,
		MkdnTableNextCell = { "i", "<Tab>" },
		MkdnTablePrevCell = { "i", "<S-Tab>" },
		MkdnTableNextRow = false,
		MkdnTablePrevRow = { "i", "<M-CR>" },
		MkdnTableNewRowBelow = { "n", "<leader>ir" },
		MkdnTableNewRowAbove = { "n", "<leader>iR" },
		MkdnTableNewColAfter = { "n", "<leader>ic" },
		MkdnTableNewColBefore = { "n", "<leader>iC" },
		-- these are telescope mappings
		MkdnFoldSection = false,
		MkdnUnfoldSection = false,
	},
})
