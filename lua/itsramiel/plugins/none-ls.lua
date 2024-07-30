return {
	"nvimtools/none-ls.nvim", -- configure formatters & linters
	event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")

		local null_ls = require("null-ls")

		local null_ls_utils = require("null-ls.utils")

		mason_null_ls.setup({
			ensure_installed = {
				"prettierd", -- prettier formatter
				"stylua", -- lua formatter
			},
		})

		-- for conciseness
		local formatting = null_ls.builtins.formatting -- to setup formatters

		-- configure null_ls
		null_ls.setup({
			-- add package.json as identifier for root (for typescript monorepos)
			root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
			-- setup formatters & linters
			sources = {
				formatting.prettierd, -- js/ts formatter
				formatting.stylua, -- lua formatter
				null_ls.builtins.formatting.swiftformat, -- swift formatter
				null_ls.builtins.formatting.swiftlint, -- swift linter
			},
		})
	end,
}
