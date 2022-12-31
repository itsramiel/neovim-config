-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  -- when a buffer/file is opened, exapdn the tree to reveal it
  update_focused_file = {
    enable = true,
  }
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
