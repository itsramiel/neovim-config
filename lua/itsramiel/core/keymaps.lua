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

opts.desc = "Reload nvim config"
keymap.set("n", "<leader>cr", function()
	for pkg, _ in pairs(package.loaded) do
		if pkg:match("^itsramiel.+") then
			package.loaded[pkg] = nil
			require(pkg)
		end
	end
end)

-- terminal
opts.desc = "Open a terminal"
keymap.set("n", "<leader>to", ":terminal<CR>")

opts.desc = "Exit terminal mode"
keymap.set("t", "<Esc>", [[<C-\><C-n>]])
