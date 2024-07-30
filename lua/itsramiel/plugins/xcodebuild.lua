return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-tree.lua", -- (optional) to manage project files
		"nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
	},
	config = function()
		require("xcodebuild").setup({
			-- put some options here or leave it empty to use default settings
		})

		local opts = { noremap = true, silent = true }

		opts.desc = "Show Xcodebuild Actions"
		vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", opts)

		opts.desc = "Show Project Manager Actions"
		vim.keymap.set("n", "<leader>xf", "<cmd>XcodebuildProjectManager<cr>", opts)

		opts.desc = "Build Project"
		vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", opts)

		opts.desc = "Build & Run Project"
		vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", opts)

		opts.desc = "Toggle Xcodebuild Logs"
		vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", opts)

		opts.desc = "Select Device"
		vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", opts)
	end,
}
