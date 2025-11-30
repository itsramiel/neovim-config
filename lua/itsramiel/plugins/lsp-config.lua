return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Format and save"
			keymap.set("n", "<leader>w", "<cmd>lua vim.lsp.buf.format()<CR><cmd>:w<CR>", opts) -- show definition, references

			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Start LSP"
			keymap.set("n", "<leader>ls", ":LspStart<CR>", opts) -- mapping to start lsp
			opts.desc = "Stop LSP"
			keymap.set("n", "<leader>lx", ":LspStop<CR>", opts) -- mapping to stop lsp
			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts) -- mapping to restart lsp

			if client.server_capabilities.inlayHintProvider then
				opts.desc = "Toggle inlay hints for the attached lsp server"
				keymap.set("n", "<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr }), { bufnr })
				end, opts) -- mapping to restart lsp if necessary
			end
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- configure html server
		vim.lsp.enable("html")
		vim.lsp.config["html"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure html server
		vim.lsp.enable("ts_ls")
		vim.lsp.config["ts_ls"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure jsonls server with plugin
		vim.lsp.enable("jsonls")
		vim.lsp.config["jsonls"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure eslint server with plugin
		vim.lsp.enable("eslint")
		vim.lsp.config["eslint"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure css server
		vim.lsp.enable("cssls")
		vim.lsp.config["cssls"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}
		--
		-- configure kotlin server
		vim.lsp.enable("kotlin_lsp")
		vim.lsp.config["kotlin_lsp"] = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure cpp server
		vim.lsp.enable("clangd")
		vim.lsp.config["clangd"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure graphql language server
		vim.lsp.enable("graphql")
		vim.lsp.config["graphql"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		}

		-- configure cmake language server
		vim.lsp.enable("cmake")
		vim.lsp.config["cmake"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure flow language server
		vim.lsp.enable("sourcekit")
		vim.lsp.config["sourcekit"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		vim.lsp.enable("yamlls")
		vim.lsp.config["yamlls"].setup = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- configure lua server (with special settings)
		vim.lsp.enable("lua_ls")
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using (most
						-- likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths
							-- here.
							-- '${3rd}/luv/library'
							-- '${3rd}/busted/library'
						},
						-- Or pull in all of 'runtimepath'.
						-- NOTE: this is a lot slower and will cause issues when working on
						-- your own configuration.
						-- See https://github.com/neovim/nvim-lspconfig/issues/3189
						-- library = {
						--   vim.api.nvim_get_runtime_file('', true),
						-- }
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})
	end,
}
