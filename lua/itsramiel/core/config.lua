vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "Podfile", "Fastfile" },
	command = "set filetype=ruby",
})
