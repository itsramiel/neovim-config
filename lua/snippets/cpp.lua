local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

return {
	s(
		"log",
		fmt("std::cout{} << {} << '\\n';{}", {
			i(2),
			i(1),
			i(0),
		})
	),
	s(
		"clo",
		fmt("std::cout << \"{} \" << {} << '\\n';{}", {
			i(1),
			rep(1),
			i(0),
		})
	),
}
