local ok, mkdnflow = pcall(require, "mkdnflow")
if not ok then
	vim.notify("mkdnflow not installed...", vim.log.ERROR)
	return
end

mkdnflow.setup({
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
		MkdnTableNextCell = false,
		MkdnTablePrevCell = false,
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
