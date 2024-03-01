return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true, desc = "Display text cases in telescope" }

    keymap.set('n', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', opts)
    keymap.set('v', 'ga.', '<cmd>TextCaseOpenTelescope<CR>', opts)
  end,
}
