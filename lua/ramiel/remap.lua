vim.g.mapleader = " "

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Map saving file to macth lsp formatted save
vim.keymap.set("n", "<leader>s", ":w<CR>")

-- move line up and down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- move to next and previous buffer
vim.keymap.set("n", "<leader>x", ":bn<CR>")
vim.keymap.set("n", "<leader>z", ":bp<CR>")

-- close all buffers(including nvim-tree) except current one
vim.keymap.set("n", "<leader>ko", ":%bd|e#|bd#<CR>") -- kill others
vim.keymap.set("n", "<leader>ka", ":bufdo bd<CR>") -- kill all
vim.keymap.set("n", "<leader>ks", ":bd<CR>") -- kill self
vim.keymap.set("n", "<leader>kh", ":bp|bd #<CR>") -- kill self
vim.keymap.set("n", "<leader>kl", ":bn|bd #<CR>") -- kill self

-- keep cursor in the middle when going to next/previous search
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- keep cursor in the middle when going to next/previous occurence
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- copying to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z")
