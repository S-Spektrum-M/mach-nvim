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
map("n", "U", "<C-r>", silent_opts_desc("undo"))
map("n", "<Leader>if", "<cmd>InitFdCache<CR>", silent_opts_desc("build cache for fd"))
map("n", "<Leader>ff", "<cmd>ListFdFiles<CR>", silent_opts_desc("list files from fd cache"))
