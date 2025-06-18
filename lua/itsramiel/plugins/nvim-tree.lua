return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local ntree = require("nvim-tree")
		local api = require("nvim-tree.api")

		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true

		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

		local function my_on_attach(bufnr)
			local function opts(desc)
				return {
					desc = "nvim-tree: " .. desc,
					buffer = bufnr,
					noremap = true,
					silent = true,
					nowait = true,
				}
			end

			-- vim.keymap.set("n", "f", api.live_filter.start, opts("Start Live Filter"))
			-- vim.keymap.set("n", "F", api.live_filter.clear, opts("Start Live Clear"))

			-- vim.keymap.set("n", "X", api.tree.expand_all, opts("Expand All"))
			vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse All"))

			vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
			vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", "a", api.fs.create, opts("Create File Or Directory"))
			vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
			vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
			vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))

			vim.keymap.set("n", "q", api.tree.close, opts("Close"))
			vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))

			vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
			vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
			vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))

			vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
			vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))

			vim.keymap.set("n", "bt", api.marks.toggle, opts("Toggle Bookmark"))
			vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
			vim.keymap.set("n", "bm", api.marks.bulk.move, opts("Move Bookmarked"))

			vim.keymap.set("n", "rn", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "rp", api.fs.rename_full, opts("Rename: Full Path"))
			vim.keymap.set("n", "rb", api.fs.rename_basename, opts("Rename: Basename"))

			vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy Name"))
			vim.keymap.set("n", "yb", api.fs.copy.basename, opts("Copy Basename"))
			vim.keymap.set("n", "yrp", api.fs.copy.relative_path, opts("Copy Relative Path"))
			vim.keymap.set("n", "yap", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))

			vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
			vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))

			vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))

			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
		end

		-- configure nvim-tree
		ntree.setup({
			filters = {
				custom = { "^.git$", "node_modules" },
			},
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
			-- https://github.com/nvim-tree/nvim-tree.lua/issues/2723#issuecomment-2016667970
			filesystem_watchers = {
				ignore_dirs = {
					"node_modules",
				},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
	end,
}
