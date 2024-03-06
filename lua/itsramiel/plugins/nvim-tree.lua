return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

      -- add default mappings
			api.config.mappings.default_on_attach(bufnr)

      -- remove default mapping which is usally for scrolling down
			vim.keymap.del("n", "<C-E>", { buffer = bufnr })
		end

		-- configure nvim-tree
		require("nvim-tree").setup({
			on_attach = my_on_attach,
			view = {
				width = 50,
				relativenumber = true,
			},
			update_focused_file = {
				enable = true,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
	end,
}
