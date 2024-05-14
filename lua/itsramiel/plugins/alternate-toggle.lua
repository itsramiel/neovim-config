return {
  'rmagatti/alternate-toggler',
  config = function()
    local alternate_toggle = require("alternate-toggler")
    alternate_toggle.setup({})

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    opts.desc = "toggle current symbol"
    keymap.set("n", "<leader>ta", "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>", opts)
  end,
  event = { "BufReadPost" }, -- lazy load after reading a buffer
}
