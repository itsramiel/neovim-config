return {
	"supermaven-inc/supermaven-nvim",
	event = { "BufReadPost" }, -- lazy load after reading a buffer
	config = function()
		require("supermaven-nvim").setup({
			condition = function()
				return true
			end,
		})
		local keymap = vim.keymap

		local opts = { noremap = true, silent = true, desc = "Toggle supermaven" }
		keymap.set("n", "<leader>it", "<cmd>SupermavenToggle<CR>", opts)
	end,
}
