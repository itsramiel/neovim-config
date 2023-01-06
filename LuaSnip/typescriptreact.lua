local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local get_visual = function (_, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local get_filename = function(_, parent)
  return sn(nil, i(1, parent.snippet.env.TM_FILENAME_BASE))
end

return {
  -- Typescript related snippets
  s({ trig="log", dscr="Expands 'log' into 'console.log(placeholder)'"},
    fmt("console.log({});", {d(1, get_visual)})
  ),

  s({trig="clo", dscr="Expands 'clo' to console.log('placeholder', placeholder)"},
    fmt("console.log('{}', {});", {d(1, get_visual), rep(1)})
  ),

  s({trig = "eaf", dscr = "arrow function with the name being the file name"},
  fmt([[
  export const {} = ({}) => {{
    {}
  }}
  ]],
  { d(1, get_filename), i(2), i(0)}
  )
  ),
  -- React related snippets

  s({trig = "eafi", dscr = "arrow function with the name being the file name and arguments defined using an interface"},
  fmt([[
  interface {}Props {{
    {}
  }}

  export const {} = ({{{}}}: {}Props) => {{
    {}
  }}
  ]],
  { d(1, get_filename), i(2), rep(1), i(3), rep(1), i(0)}
  )
  ),

  s({trig = "eaft", dscr = "arrow function with the name being the file name and arguments defined using an interface"},
  fmt([[
  type T{}Args = {}

  export const {} = ({}: T{}Args) => {{
    {}
  }}
  ]],
  { d(1, get_filename), i(2), rep(1), i(3), rep(1), i(0)}
  )
  )
}


