local map = vim.api.nvim_set_keymap
local opts = { noremap = true }
local opts_silent = { noremap = true, silent = true }

-- LSP
map("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "gR", "<CMD>lua vim.lsp.buf.code_action({refactor})<CR>", opts)
-- Misc
map("n", "<Leader><F2>", ":lua vim.lsp.buf.format()", opts)
map("n", "t", "`", opts_silent) -- Will unbind default behavior of t in normal mode
map("n", "<C-l>", "<cmd>nohlsearch<CR>", opts_silent)
map("v", "x", "d", opts_silent)
map("n", "U", "<C-r>", opts_silent) -- stolen from helix
