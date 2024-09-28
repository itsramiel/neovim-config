return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local bufferline = require("bufferline")

		local opts = { noremap = true, silent = true }
		local keymap = vim.keymap

		-- Moving between buffer
		opts.desc = "Go to next buffer"
		keymap.set("n", "<C-.>", ":BufferLineCycleNext<CR>", opts)
		opts.desc = "Close all but current buffer"
		keymap.set("n", "<C-,>", ":BufferLineCyclePrev<CR>", opts)

		-- Moving buffers
		opts.desc = "Move buffer to the left"
		keymap.set("n", "<C-[>", ":BufferLineMovePrev<CR>", opts)
		opts.desc = "Move buffer to the right"
		keymap.set("n", "<C-]>", ":BufferLineMoveNext<CR>", opts)

		-- Closing buffers
		opts.desc = "Close current buffer"
		keymap.set("n", "<leader>ks", ":bd<CR>", opts)
		opts.desc = "Kill all other buffers"
		keymap.set("n", "<leader>ko", ":BufferLineCloseOthers<CR>", opts)
		opts.desc = "Kill current buffer and go to next"

		keymap.set("n", "<leader>kl", function()
			local currentBuffer = vim.fn.bufnr("%")
			bufferline.cycle(1)
			vim.cmd("bd " .. currentBuffer)
		end, opts)

		opts.desc = "Kill current buffer and go to previous"
		keymap.set("n", "<leader>kh", function()
			local currentBuffer = vim.fn.bufnr("%")
			bufferline.cycle(-1)
			vim.cmd("bd " .. currentBuffer)
		end, opts)

		opts.desc = "Kill all buffers"
		keymap.set("n", "<leader>ka", ":bufdo bd<CR>", opts)

		bufferline.setup({
			options = {
				mode = "buffers",
				separator_style = "slant",
				diagnostics = "nvim_lsp",
				numbers = "ordinal",
				show_tab_indicators = true,
			},
		})
	end,
}
