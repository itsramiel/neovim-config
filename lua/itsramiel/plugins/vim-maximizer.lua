return {
  "szw/vim-maximizer",
  config = function()

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }

    opts.desc = "toggle split window maximization"
    keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
  end
}
