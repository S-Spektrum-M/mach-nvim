local map = vim.keymap.set
local opts_silent = { noremap = true, silent = true }

map("n", "<Leader>l", "<cmd>nohlsearch<CR>", opts_silent)
map("v", "x", "d", opts_silent)
map("n", "U", "<C-r>", opts_silent) -- stolen from helix
