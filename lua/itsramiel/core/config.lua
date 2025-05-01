vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "Podfile", "Fastfile", "*.podspec" },
	command = "set filetype=ruby",
})

vim.lsp.log.set_level(vim.log.levels.OFF)
