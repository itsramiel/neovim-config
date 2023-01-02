vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", function() vim.cmd('Ex') end)


-- move line up and down
vim.keymap.set("n", "J", ":m .+1<CR>==")
vim.keymap.set("n", "K", ":m .-2<CR>==")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move to next and previous buffer
vim.keymap.set("n", "<leader>x", ":bn<CR>")
vim.keymap.set("n", "<leader>z", ":bp<CR>")
