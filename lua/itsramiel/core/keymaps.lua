local keymap = vim.keymap

local opts = { noremap = true }

opts.desc = "Match lsp save file"
keymap.set("n", "<leader>w", "<cmd>w<CR>", opts)

opts.desc = "Move line down"
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
opts.desc = "Move line up"
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

opts.desc = "Move line down"
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
opts.desc = "Move line up"
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

opts.desc = "Move line down"
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
opts.desc = "Move line up"
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

opts.desc = "Keep cursor in place when wrapping Line"
keymap.set("n", "J", "mzJ`z", opts)

opts.desc = "keep cursor in the middle when going to next search occurence"
keymap.set("n", "n", "nzz", opts)
opts.desc = "kepp cursor in the middle when going to previous search occurence"
keymap.set("n", "n", "nzz", opts)

opts.desc = "kepp cursor in the middle when going to next occurence"
keymap.set("n", "*", "*zz", opts)
opts.desc = "kepp cursor in the middle when going to previous occurence"
keymap.set("n", "#", "#zz", opts)

opts.desc = "Copy to system clipboard"
keymap.set("n", "<leader>y", '"+y', opts)
keymap.set("v", "<leader>y", '"+y', opts)

opts.desc = "Clear search highlight"
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- window management
opts.desc = "split window vertically"
keymap.set("n", "<leader>sv", "<C-w>v")
opts.desc = "split window horizontally"
keymap.set("n", "<leader>sh", "<C-w>s")
opts.desc = "make split windows equal width & height"
keymap.set("n", "<leader>s=", "<C-w>=")
opts.desc = "close current split window"
keymap.set("n", "<leader>sx", ":close<CR>")
opts.desc = "Swap splits"
keymap.set("n", "<leader>ss", "<C-W>R")

opts.desc = "Jump to next non-whitespace matching indentation"
keymap.set({ "n", "v" }, "<M-,>", function()
  vim.cmd("call search('^'. matchstr(getline('.'), '\\(^\\s*\\)') .'\\%<' . line('.') . 'l\\S', 'be')")
end, opts)

opts.desc = "Jump to previous non-whitespace matching indentation"
keymap.set({ "n", "v" }, "<M-.>", function()
  vim.cmd("call search('^'. matchstr(getline('.'), '\\(^\\s*\\)') .'\\%>' . line('.') . 'l\\S', 'e')")
end, opts)

-- Jump to the next/precious number
opts.desc = "Jump to the next number"
keymap.set("n", "<leader>nn", "/\\d\\+<CR>", opts)
opts.desc = "Jump to the previous number"
keymap.set("n", "<leader>pn", "?\\d\\+<CR>", opts)

opts.desc = "Keep cursor position after yanking"
keymap.set("v", "Y", "ygv<Esc>", opts)

-- Esc maps to <C-[> for some reason which I use to move tabs
opts.desc = "Map escape to <C-c>"
keymap.set("n", "<Esc>", "<C-c>")

---@class CodeColumns
---@field start_col integer Character column where the selection starts, counted from 1.
---@field end_col integer Character column where the selection ends, counted from 1 and inclusive.

---@class CodeRange
---@field start_line integer
---@field end_line integer
---@field columns? CodeColumns Set only for a charwise selection within one line that doesn't span the whole line.

---@param line string
---@param byte_col integer Byte column, counted from 1.
---@return integer char_col Character column, counted from 1.
local function to_char_col(line, byte_col)
  -- In visual mode, `$` puts the cursor one byte past the end of the line.
  local clamped = math.min(byte_col, #line)
  return vim.fn.charidx(line, clamped - 1) + 1
end

-- Returns nil when the selection spans the whole line, so the reference carries no columns.
---@param line_nr integer
---@param start_byte integer
---@param end_byte integer
---@return CodeColumns?
local function column_range(line_nr, start_byte, end_byte)
  local line = vim.fn.getline(line_nr)
  local start_col = to_char_col(line, start_byte)
  local end_col = to_char_col(line, end_byte)
  if start_col <= 1 and end_col >= vim.fn.strchars(line) then
    return nil
  end
  return { start_col = start_col, end_col = end_col }
end

-- Returns the line range of the visual selection, or of the cursor line outside visual mode.
-- A char wise selection within one line also gets a column range.
---@return CodeRange
local function current_range()
  local cursor = vim.fn.getpos(".")
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" and mode ~= "\22" then
    return { start_line = cursor[2], end_line = cursor[2] }
  end

  local start_pos, end_pos = vim.fn.getpos("v"), cursor
  if start_pos[2] > end_pos[2] or (start_pos[2] == end_pos[2] and start_pos[3] > end_pos[3]) then
    start_pos, end_pos = end_pos, start_pos
  end

  ---@type CodeRange
  local range = { start_line = start_pos[2], end_line = end_pos[2] }
  if mode == "v" and range.start_line == range.end_line then
    range.columns = column_range(range.start_line, start_pos[3], end_pos[3])
  end
  return range
end

---@param path string
---@param range CodeRange
---@return string
local function format_reference(path, range)
  local reference = path .. ":" .. range.start_line
  if range.end_line ~= range.start_line then
    return reference .. "-" .. range.end_line
  end
  local columns = range.columns
  if columns then
    return reference .. ":" .. columns.start_col .. "-" .. columns.end_col
  end
  return reference
end

local function copy_code_reference()
  if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
    vim.notify("No file to reference", vim.log.levels.WARN)
    return
  end

  local path = vim.fn.expand("%:~:.")
  vim.fn.setreg("+", format_reference(path, current_range()))
  if vim.fn.mode() ~= "n" then
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  end
end

opts.desc = "Copy code reference to clipboard"
keymap.set({ "n", "v" }, "<leader>cr", copy_code_reference, opts)

-- terminal
opts.desc = "Open a terminal"
keymap.set("n", "<leader>to", ":terminal<CR>")

opts.desc = "Exit terminal mode"
keymap.set("t", "<Esc>", [[<C-\><C-n>]])

opts.desc = "Toggle wrap"
keymap.set("n", "<leader>tw", function()
  local wrap_enabled = vim.wo.wrap
  vim.wo.wrap = not wrap_enabled
end)
