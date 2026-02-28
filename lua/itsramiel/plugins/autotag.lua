return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPost" }, -- lazy load after reading a buffer
  config = function()
    require('nvim-ts-autotag').setup({
      per_filetype = {
        ["markdown"] = {
          enable_close = false
        }
      }
    })
  end
}
