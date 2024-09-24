return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local gitsigns = require('gitsigns')

    gitsigns.setup({
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        local opts = { noremap = true, silent = true }

        -- Navigation
        opts.desc = "Gitsigns: next hunk"
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, opts)

        opts.desc = "Gitsigns: prev hunk"
        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, opts)

        -- Actions
        opts.desc = "Gitsigns: stage hunk"
        map('n', '<leader>hs', gs.stage_hunk, opts)
        opts.desc = "Gitsigns: stage buffer"
        map('n', '<leader>hS', gs.stage_buffer, opts)
        opts.desc = "Gitsigns: reset hunk"
        map('n', '<leader>hr', gs.reset_hunk, opts)
        opts.desc = "Gitsigns: reset hunk"
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, opts)
        opts.desc = "Gitsigns: reset buffer"
        map('n', '<leader>hR', gs.reset_buffer, opts)
        opts.desc = "Gitsigns: preview hunk"
        map('n', '<leader>hp', gs.preview_hunk, opts)
        opts.desc = "Gitsigns: preview blame"
        map('n', '<leader>hb', gs.blame_line, opts)
        opts.desc = "Gitsigns: toggle blame"
        map('n', '<leader>tb', gs.toggle_current_line_blame, opts)
        opts.desc = "Gitsigns: toggle diff"
        map('n', '<leader>hd', gs.diffthis, opts)
        opts.desc = "Gitsigns: toggle deleted"
        map('n', '<leader>td', gs.toggle_deleted, opts)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    })
  end
}
