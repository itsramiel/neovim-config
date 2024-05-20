return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	config = function()
		local ls = require("luasnip")

		ls.setup({
			update_events = { "TextChanged", "TextChangedI" },
		})

		vim.keymap.set({ "i" }, "<C-K>", function()
			ls.expand()
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-H>", function()
			ls.jump(-1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })

		ls.filetype_extend("javascriptreact", { "javascript" })
		ls.filetype_extend("typescriptreact", { "javascriptreact" })
		ls.filetype_extend("typescriptreact", { "javascript" })
		ls.filetype_extend("typescript", { "javascript" })
	end,
}
