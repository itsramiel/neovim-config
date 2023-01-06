local ls = require("luasnip")

ls.config.set_config {
  update_events = 'TextChanged,TextChangedI',
  store_selection_keys = '<Tab>',
}

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
-- Yes, we're just executing a bunch of Vimscript using vim.cmd

vim.keymap.set({"i", "s"}, "<c-k>", function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, {silent = true})

vim.keymap.set({"i", "s"}, "<c-j>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, {silent = true})

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})


