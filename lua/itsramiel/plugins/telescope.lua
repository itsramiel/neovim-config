return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		local function filename_first(_, path)
			local tail = vim.fs.basename(path)
			local parent = vim.fs.dirname(path)
			if parent == "." then
				return tail
			end
			return string.format("%s\t\t%s", tail, parent)
		end

		-- highlights filename results
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "TelescopeResults",
			callback = function(ctx)
				vim.api.nvim_buf_call(ctx.buf, function()
					vim.fn.matchadd("TelescopeParent", "\t\t.*$")
					vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
				end)
			end,
		})

		telescope.setup({
			defaults = {
				path_display = filename_first,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep in cwd" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Open buffers" })
		keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
		keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status in telescope" })
		keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branch in telescope" })
		keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits in telescope" })
		keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Display keymaps in telescope" })
		keymap.set(
			"n",
			"gi",
			builtin.lsp_implementations,
			{ desc = "Go or show all implementations of word under cursor" }
		)
		keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go or show all definitions of word under cursor" })
		keymap.set(
			"n",
			"gt",
			builtin.lsp_type_definitions,
			{ desc = "Go or show all type definitions of word under cursor" }
		)
	end,
}
