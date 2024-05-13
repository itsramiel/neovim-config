vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "Podfile",
	command = "set filetype=ruby",
})
