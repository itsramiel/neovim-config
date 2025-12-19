return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {},
		image = {},
		indent = {},
		notifier = {},
		lazygit = {},
	},
	keys = {
		{
			"<leader>lh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
