return {
	"phelipetls/jsonpath.nvim",
	ft = { "json" },
	config = function()
		local opts = { noremap = true, silent = true, desc = "Toggle path to json key" }

		vim.keymap.set("n", "<leader>tjp", function()
			-- Check if the 'winbar' option is available and if it is not set
			if vim.fn.exists("+winbar") == 1 and (vim.wo.winbar == nil or vim.wo.winbar == "") then
				vim.wo.winbar = "%{%v:lua.require'jsonpath'.get()%}"
			else
				vim.wo.winbar = ""
			end
		end, opts)

		opts.desc = "Copy json path to clipboard"

		-- send json path to clipboard
		vim.keymap.set("n", "<leader>yjp", function()
			local json_path = require("jsonpath").get()
			vim.fn.setreg("+", json_path:sub(2))
		end, opts)
	end,
}
