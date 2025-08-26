return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local utils = require("telescope.utils")
    local action_state = require("telescope.actions.state")
    local finders = require("telescope.finders")
    local make_entry = require("telescope.make_entry")
    local transform_mod = require("telescope.actions.mt").transform_mod

    -- highlights filename results
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "TelescopeResults",
      callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
          vim.fn.matchadd("TelescopeParent", "\t\t.*$")
          vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
        end)
      end,
    })

    local copy_relative_file_path = function(_)
      local selection = action_state.get_selected_entry()
      vim.fn.setreg("+", selection.value)
    end

    local copy_absolute_file_path = function(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      local cwd = picker.cwd or vim.loop.cwd()
      local file_path = vim.fs.joinpath(cwd, selection.value)
      vim.fn.setreg("+", file_path)
    end

    local restore_file_action = function(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      local cwd = picker.cwd
      local status = selection.status

      if status == " D" or status == " M" then
        utils.get_os_command_output({ "git", "restore", selection.value }, cwd)
      elseif status == "D " or status == "M " then
        utils.get_os_command_output({ "git", "restore", "--staged", selection.value }, cwd)
      end
    end

    local open_finder = function(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      local cwd = picker.cwd or vim.loop.cwd()
      local file_path = vim.fs.joinpath(cwd, selection.value)
      local parent_directory = vim.fs.dirname(file_path)

      vim.ui.open(parent_directory)
    end

    local custom_actions = transform_mod({
      restore_file = function(prompt_bufnr)
        restore_file_action(prompt_bufnr)
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
          },
        },
      },
      pickers = {
        find_files = {
          attach_mappings = function(_, map)
            map("n", "s", open_finder)
            map("n", "yrp", copy_relative_file_path)
            map("n", "yap", copy_absolute_file_path)
            return true
          end,
        },
        git_status = {
          attach_mappings = function(_, map)
            custom_actions.restore_file:enhance({
              post = function(prompt_bufnr)
                local picker = action_state.get_current_picker(prompt_bufnr)
                local current_row = picker:get_selection_row()
                local current_index = picker:get_index(current_row)
                local total_items = #picker.finder.results

                local callbacks = { unpack(picker._completion_callbacks) }
                picker:register_completion_callback(function(self)
                  local new_picker = action_state.get_current_picker(prompt_bufnr)
                  local new_total_items = #new_picker.finder.results

                  local new_row
                  if total_items <= 1 then
                    new_row = nil
                  elseif new_total_items == total_items then
                    new_row = current_row
                  elseif current_index < total_items then
                    new_row = current_row
                  else
                    new_row = current_row + 1
                  end

                  if new_row then
                    self:set_selection(new_row)
                  end
                  self._completion_callbacks = callbacks
                end)

                -- rebuild finder
                local args = { "status", "--porcelain=v1", "--", "." }
                if vim.F.if_nil(picker.expand_dir, true) then
                  table.insert(args, #args - 1, "-uall")
                end

                local git_command = utils.__git_command

                local git_cmd = git_command(args, picker)
                local entry_maker = make_entry.gen_from_git_status(picker)
                local new_finder = finders.new_oneshot_job(git_cmd, { entry_maker = entry_maker })

                picker:refresh(new_finder, { reset_prompt = false })
              end,
            })
            map("n", "rs", custom_actions.restore_file)
            map("n", "yrp", copy_relative_file_path)
            map("n", "yap", copy_absolute_file_path)
            map("n", "s", open_finder)
            return true
          end,
        },
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep in cwd" })
    keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Open buffers" })
    keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
    keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status in telescope" })
    keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branch in telescope" })
    keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits in telescope" })
    keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Display keymaps in telescope" })
    keymap.set(
      "n",
      "gi",
      builtin.lsp_implementations,
      { desc = "Go or show all implementations of word under cursor" }
    )
    keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go or show all definitions of word under cursor" })
    keymap.set(
      "n",
      "gt",
      builtin.lsp_type_definitions,
      { desc = "Go or show all type definitions of word under cursor" }
    )
  end,
}
