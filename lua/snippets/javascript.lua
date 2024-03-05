local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
-- local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
-- local l = require("luasnip.extras").lambda

local function firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

return {
	s(
		"log",
		fmt("console.log({}{}{});", {
			c(1, { t('"'), t("'") }),
			i(2),
			rep(1),
		})
	),
	s(
		"clo",
		fmt("console.log({}{}{},{});", {
			c(1, { t('"'), t("'") }),
			i(2),
			rep(1),
			rep(2),
		})
	),
	s(
		"useState",
		fmt("const [{}, set{}] = useState{}({});", {
			i(1),
			f(function(args)
				return firstToUpper(args[1][1])
			end, { 1 }),
			c(2, {
				fmt("<{}>", i(1)),
				t(""),
			}),
			i(3),
		})
	),
	s(
		"useRef",
		fmt("const {} = useRef{}({});", {
			i(1),
			c(2, {
				fmt("<{}>", i(1)),
				t(""),
			}),
			i(3),
		})
	),
	s(
		"useEffect",
		fmt(
			[[
  useEffect(() => {{
    {}
  }}, [])
  ]],
			{ i(0) }
		)
	),
	s(
		"f",
		fmt(
			[[
    {}function {}({}){} {{
      {}
    }}
    ]],
			{
				c(1, {
					t("export "),
					t(""),
				}),
				d(2, function(_, parent)
					return sn(nil, {
						i(1, parent.env.TM_FILENAME_BASE),
					})
				end),
				i(3),
				i(4),
				i(0),
			}
		)
	),
	s(
		"iaf",
		fmt(
			[[
      ({}) => {{
        {}
      }}
    ]],
			{
				i(1),
				i(0),
			}
		)
	),
}
