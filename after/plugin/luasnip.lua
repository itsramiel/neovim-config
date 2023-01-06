local ls = require("luasnip")

ls.config.set_config {
  update_events = 'TextChanged,TextChangedI',
  store_selection_keys = '<Tab>',
}

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
-- Yes, we're just executing a bunch of Vimscript using vim.cmd
vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip/"})


