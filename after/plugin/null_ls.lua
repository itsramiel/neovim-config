local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
	null_ls.builtins.diagnostics.eslint_d,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
		callback = function()
		    vim.lsp.buf.format({
        		bufnr = bufnr,
			-- makes sure to use null-ls, not lsp or smthn else, for formatting
		        filter = function(client)
			    return client.name == "null-ls"
			end
		    })
		end,
            })
        end
    end,
})
