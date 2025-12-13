return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = { enabled = true },
    image = {},
    indent = {},
    notifier = {},
    lazygit = {},
  },
  config = function()
    local snacks = require("snacks")

    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }

    opts.desc = "Display help list"
    keymap.set("n", "<leader>lh", function()
      snacks.picker.help()
    end, opts)

    opts.desc = "Lazy git"
    keymap.set("n", "<leader>lg", function()
      snacks.lazygit.open()
    end, opts)
  end,
}
