local ls = require("luasnip")
local t = ls.text_node
local c = ls.choice_node
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	s(
		"log",
		fmt("print({}{}{});", {
			c(1, { t('"'), t("'"), t("") }),
			i(2),
			rep(1),
		})
	),
	s(
		"clo",
		fmt("print({}{}{},{});", {
			c(1, { t('"'), t("'") }),
			i(2),
			rep(1),
			rep(2),
		})
	),
}
