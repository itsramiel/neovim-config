return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			on_attach = function(bufnr)
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				local opts = { noremap = true, silent = true }

				-- Navigation
				opts.desc = "Gitsigns: next hunk"
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				opts.desc = "Gitsigns: prev hunk"
				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				opts.desc = "Gitsigns: stage hunk"
				map("n", "<leader>hs", gitsigns.stage_hunk, opts)
				opts.desc = "Gitsigns: stage buffer"
				map("n", "<leader>hS", gitsigns.stage_buffer, opts)
				opts.desc = "Gitsigns: reset hunk"
				map("n", "<leader>hr", gitsigns.reset_hunk, opts)
				opts.desc = "Gitsigns: reset buffer"
				map("n", "<leader>hR", gitsigns.reset_buffer, opts)
				opts.desc = "Gitsigns: preview hunk"
				map("n", "<leader>hp", gitsigns.preview_hunk, opts)
				opts.desc = "Gitsigns: preview blame"
				map("n", "<leader>hb", gitsigns.blame_line, opts)
				opts.desc = "Gitsigns: toggle blame"
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)
				opts.desc = "Gitsigns: toggle diff"
				map("n", "<leader>hd", gitsigns.diffthis, opts)
				opts.desc = "Gitsigns: toggle deleted"
				map("n", "<leader>td", gitsigns.preview_hunk_inline, opts)
			end,
		})
	end,
}
