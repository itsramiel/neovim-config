return {
  "itsramiel/sim.nvim",
  dependencies = {
    "gregorias/coop.nvim",
  },
  config = function()
    local sim_ui = require("sim.ui")

    local keymap = vim.keymap

    local opts = {
      noremap = true,
      silent = true,
      desc = "Prompts ios device to launch. If there is only one, it launches it directly",
    }
    keymap.set("n", "<leader>sbi", sim_ui.boot.boot_ios_virtual_device, opts)

    opts.desc = "Prompts ios device to shutdown. If there is only one, it shuts it down directly"
    keymap.set("n", "<leader>ssi", sim_ui.shutdown.shutdown_ios_virtual_device, opts)

    opts.desc = "Prompts android device to launch. If there is only one, it launches it directly"
    keymap.set("n", "<leader>sba", sim_ui.boot.boot_android_virtual_device, opts)

    opts.desc = "Prompts android virtual device to shutdown. If there is only one, it shuts it down directly"
    keymap.set("n", "<leader>ssa", sim_ui.shutdown.shutdown_android_virtual_device, opts)

    opts.desc = "Shuts down all virtual devices(iOS & Android)"
    keymap.set("n", "<leader>ssx", sim_ui.shutdown.shutdown_all_virtual_devices, opts)

    opts.desc = "List devices to perform an action on"
    keymap.set("n", "<leader>sl", sim_ui.list_devices.list_all, opts)
  end,
}
