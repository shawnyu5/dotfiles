local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

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
