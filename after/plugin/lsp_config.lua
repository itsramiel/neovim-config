local lspConfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function()
	-- simulate mouse hover to get info
	vim.keymap.set("n", "I", vim.lsp.buf.hover, {buffer = 0})
	-- go to definition
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
	-- go to next/previous error/warning aka diagnostic
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {buffer = 0})
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {buffer = 0})
	-- rename
	-- If renaming happens in other buffers too, you need to manually save
	-- other buffers by doing `:wa`
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})

	-- code actions
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer = 0})
end

lspConfig.rust_analyzer.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}

lspConfig.tsserver.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}

lspConfig.sumneko_lua.setup{
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'}
			}
		}
	}
}
