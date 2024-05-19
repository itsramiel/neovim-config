local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"rnstyle",
		fmt(
			[[
  const styles = Stylesheet{}.create({{
    {}
  }})
  ]],
			{ i(1), i(0) }
		)
	),
}
