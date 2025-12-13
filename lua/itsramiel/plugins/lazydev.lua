return {
  { "LuaCATS/busted",   name = "busted-types",   lazy = true },
  { "LuaCATS/luassert", name = "luassert-types", lazy = true },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    config = true,
    opts = {
      library = {
        { path = "busted-types/library",   words = { "describe" } },
        { path = "luassert-types/library", words = { "assert" } },
      },
    },
  },
}
