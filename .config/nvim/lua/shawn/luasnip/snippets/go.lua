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

ls.add_snippets("go", {
	--  s(
	--     "example1",
	--     fmt("just an {iNode1}", {
	--        iNode1 = i(1, "example"),
	--     })
	--  ),
	--  s(
	--     "example3",
	--     fmt(
	--        [[
	-- if <> then
	--   <>
	-- end
	-- ]],
	--        {
	--           -- i(1) is at nodes[1], i(2) at nodes[2].
	--           i(1, "not now"),
	--           i(2, "when"),
	--        },
	--        {
	--           delimiters = "<>",
	--        }
	--     )
	--  ),
	s(
		"err",
		fmt(
			[[
if <> != nil {
   <>
}
  ]],
			{
				i(1, "err"),
				i(2, "log.Fatal(err)"),
			},
			{
				delimiters = "<>",
			}
		)
	),
})

-- ls.add_snippets("go", {
--    s("err", {
--       fmt(
--          [[if <> != nil {
--             <>
--          }]],
--          {
--             i(1, "err"),
--             i(2, "log.Fatal(err)"),
--          },
--          {
--             delimiters = "<>",
--          }
--       ),
--    }),
-- })
