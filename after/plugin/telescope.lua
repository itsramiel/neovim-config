local builtin = require('telescope.builtin')

require('telescope').setup {
  defaults = {
    path_display = { "smart" },
    mappings = {
      i = {
        ['<c-k>'] = require('telescope.actions').delete_buffer,
      } -- i
    } -- mappings
  }
}

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep)
vim.keymap.set('n', '<leader>pe', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>pr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>rs', builtin.resume, {})

vim.keymap.set('n', '<leader>gs', builtin.git_status)
vim.keymap.set('n', '<leader>gc', builtin.git_commits)
