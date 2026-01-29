local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

--- Construct a snippet with git commit prefix
---@param prefix string a valid git commit
---@return snippet snippet a snippet
local function git_commit_snippet(prefix)
	return s(
		prefix,
		fmt(
			string.format(
				[[
%s({}): {}

{}
  ]],
				prefix
			),
			{
				i(1, "scope"),
				i(2, "message"),
				i(3, ""),
			},
			{}
		)
	)
end

ls.add_snippets("gitcommit", {
	git_commit_snippet("feat"),
	git_commit_snippet("fix"),
	git_commit_snippet("build"),
	git_commit_snippet("perf"),
	git_commit_snippet("docs"),
	git_commit_snippet("chore"),
	git_commit_snippet("test"),
	git_commit_snippet("ci"),
	git_commit_snippet("style"),
	git_commit_snippet("refactor"),
	s(
		"bk",
		fmt(
			[[
BREAKING CHANGE: {}

{}
   ]],
			{
				i(1, "title"),
				i(2, ""),
			},
			{}
		)
	),
})
