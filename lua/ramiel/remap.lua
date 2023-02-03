vim.g.mapleader = " "

-- Map saving file to macth lsp formatted save
vim.keymap.set("n", "<leader>s", ":w<CR>")

-- move line up and down
vim.keymap.set("n", "J", ":m .+1<CR>==")
vim.keymap.set("n", "K", ":m .-2<CR>==")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move to next and previous buffer
vim.keymap.set("n", "<leader>x", ":bn<CR>")
vim.keymap.set("n", "<leader>z", ":bp<CR>")

-- close all buffers(including nvim-tree) except current one
vim.keymap.set("n", "<leader>ko", ":%bd|e#|bd#<CR>") -- kill others
vim.keymap.set("n", "<leader>ka", ":bufdo bd<CR>") -- kill all
vim.keymap.set("n", "<leader>ks", ":bd<CR>") -- kill self

-- keep cursor in the middle when going to next/previous search
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- keep cursor in the middle when going to next/previous occurence
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- copying to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
