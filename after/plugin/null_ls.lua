local null_ls = require("null-ls")

-- https://github.com/sQVe/dotfiles/blob/master/config/nvim/lua/sQVe/plugins/null-ls.lua
-- start of making eslint turned off if no eslint config is found
local starts_with = function(str, start)
  return string.sub(str, 1, #start) == start
end

local create_runtime_condition = function(config_names)
  local bufnr_cache = {}
  local config_path_cache = {}

  return function(params)
    if bufnr_cache[params.bufnr] ~= nil then
      return bufnr_cache[params.bufnr]
    else
      for _, cached_config_path in ipairs(config_path_cache) do
        if starts_with(params.bufname, cached_config_path) then
          bufnr_cache[params.bufnr] = true
          return true
        end
      end
    end

    local config_path =
      require('lspconfig').util.root_pattern(config_names)(params.bufname)

    local has_config = config_path ~= nil
    if has_config then
      table.insert(config_path_cache, config_path)
    end
    bufnr_cache[params.bufnr] = has_config

    return has_config
  end
end

local eslint_runtime_condition = create_runtime_condition({
  '.eslintrc.cjs',
  '.eslintrc.js',
  '.eslintrc.json',
  '.eslintrc.yaml',
  '.eslintrc.yml',
})
-- end of making eslint turned off if no eslint config is found

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
    -- https://github.com/sQVe/dotfiles/blob/master/config/nvim/lua/sQVe/plugins/null-ls.lua
    null_ls.builtins.diagnostics.eslint_d.with({
      runtime_condition = eslint_runtime_condition,
      timeout = 20000,
    }),
  },
})
