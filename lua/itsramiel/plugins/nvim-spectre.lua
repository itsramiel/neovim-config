return {
	"nvim-pack/nvim-spectre",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local opts = { noremap = true, silent = true, desc = "Display text cases in telescope" }

		opts.desc = "Toggle Spectre"
		vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', opts)

		opts.desc = "Search current word"
		vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', opts)
		vim.keymap.set("v", "<leader>sp", '<esc><cmd>lua require("spectre").open_visual()<CR>', opts)

		opts.desc = "Search on current file"
		vim.keymap.set("n", "<leader>sf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', opts)
	end,
}
