local map = vim.keymap.set

local function silent_opts_desc(desc)
    return {
        noremap = true,
        silent = true,
        desc = desc
    }
end

map("n", "<Leader>l", "<cmd>nohlsearch<CR>", silent_opts_desc("clear search highlight"))
map("n", "\\", "<cmd>bnext<CR>", silent_opts_desc("go to next buffer"))
map("n", "|", "<cmd>bprevious<CR>", silent_opts_desc("go to bprevious buffer"))
map("v", "x", "d", silent_opts_desc("delete selection"))

-- Inner Line (il): first non-blank character to last non-blank character.
map("x", "il", "g_o^", silent_opts_desc("select inner line"))
map("o", "il", ":normal vil<CR>", silent_opts_desc("target inner line"))

-- Around Line (al): entire line, including leading and trailing whitespace.
map("x", "al", "$o0", silent_opts_desc("select around line"))
map("o", "al", ":normal val<CR>", silent_opts_desc("target around line"))

map("n", "U", "<C-r>", silent_opts_desc("undo"))
map("n", "<Leader>if", "<cmd>InitFdCache<CR>", silent_opts_desc("build cache for fd"))
map("n", "<Leader>ff", "<cmd>ListFdFiles<CR>", silent_opts_desc("list files from fd cache"))
map("n", "]q", "<cmd>cnext<CR>", silent_opts_desc("next quickfix item"))
map("n", "[q", "<cmd>cprev<CR>", silent_opts_desc("prev quickfix item"))
map("n", "<Leader>q", "<cmd>copen<CR>", silent_opts_desc("open quickfix list"))
map("n", "<Leader>qq", "<cmd>cclose<CR>", silent_opts_desc("close quickfix list"))
map("n", "<Leader>qd", function() vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR }) end, silent_opts_desc("dump LSP errors to quickfix"))
