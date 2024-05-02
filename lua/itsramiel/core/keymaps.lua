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
keymap.set("n", "<leader>se", "<C-w>=")
opts.desc = "close current split window"
keymap.set("n", "<leader>sx", ":close<CR>")
opts.desc = "Swap splits"
keymap.set("n", "<leader>ss", "<C-W>R")

opts.desc = "open new tab"
keymap.set("n", "<leader>to", ":tabnew<CR>")
opts.desc = "close current tab"
keymap.set("n", "<leader>tx", ":tabclose<CR>")
opts.desc = "go to next tab"
keymap.set("n", "<leader>tn", ":tabn<CR>")
opts.desc = "go to previous tab"
keymap.set("n", "<leader>tp", ":tabp<CR>")

opts.desc = "Jump to next non-whitespace matching indentation"
keymap.set({ "n", "v" }, "<M-,>", function()
	vim.cmd("call search('^'. matchstr(getline('.'), '\\(^\\s*\\)') .'\\%<' . line('.') . 'l\\S', 'be')")
end, opts)

opts.desc = "Jump to previous non-whitespace matching indentation"
keymap.set({ "n", "v" }, "<M-.>", function()
	vim.cmd("call search('^'. matchstr(getline('.'), '\\(^\\s*\\)') .'\\%>' . line('.') . 'l\\S', 'e')")
end, opts)

-- Moving between buffer
opts.desc = "Go to next buffer"
keymap.set("n", "<leader>x", ":bnext<CR>", opts)
opts.desc = "Close all but current buffer"
keymap.set("n", "<leader>z", ":bprevious<CR>", opts)

-- Closing buffers
opts.desc = "Close current buffer"
keymap.set("n", "<leader>ks", ":bd<CR>", opts)
opts.desc = "Kill all other buffers"
keymap.set("n", "<leader>ko", ":%bd|e#<CR>", opts)
opts.desc = "Kill current buffer and go to next"
keymap.set("n", "<leader>kl", ":bn|bd#<CR>", opts)
opts.desc = "Kill current buffer and go to previous"
keymap.set("n", "<leader>kh", ":bp|bd#<CR>", opts)
opts.desc = "Kill all buffers"
keymap.set("n", "<leader>ka", ":bufdo bd<CR>", opts)

keymap.set("x", "<leader>p", '"_dP')
