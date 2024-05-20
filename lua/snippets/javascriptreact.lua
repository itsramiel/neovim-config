local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"rnstyles",
		fmt(
			[[
  const styles = Stylesheet{}.create({{
    {}: {{
      {}
    }}
  }})
  ]],
			{ i(1), i(2, "container"), i(0) }
		)
	),
	s(
		"rnstyle",
		fmt(
			[[
  {}: {{
    {}
  }}
  ]],
			{ i(1, "container"), i(0) }
		)
	),
}
