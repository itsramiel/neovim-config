return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  -- or                              , branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require("telescope")
    local builtin = require('telescope.builtin')

    telescope.setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep in cwd" })
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Open buffers" })
    keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
  end,
}
