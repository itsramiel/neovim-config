local prettier_opts = { "prettierd", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      javascript      = prettier_opts,
      typescript      = prettier_opts,
      javascriptreact = prettier_opts,
      typescriptreact = prettier_opts,
      css             = prettier_opts,
      scss            = prettier_opts,
      html            = prettier_opts,
      json            = prettier_opts,
      jsonc           = prettier_opts,
      yaml            = prettier_opts,
      markdown        = prettier_opts,
      graphql         = prettier_opts,
    },
    format_on_save = {
      lsp_format = "fallback", -- replaces the older `lsp_fallback = true`
      async = false,
      timeout_ms = 1000,
    },
  },
}
