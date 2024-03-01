return {
		"bluz71/vim-nightfly-colors",
		lazy = false,
		priority = 1000,
		config = function()
			-- Lua initialization file
			vim.cmd [[colorscheme nightfly]]
		end
	}
