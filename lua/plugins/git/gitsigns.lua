return {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre" },
    config = function()
        require('gitsigns').setup(vim.mach_opts.gitsigns)
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'vim-fugitive',
    },
    keys = {
        {"ghn", "<cmd>Gitsigns next_hunk<CR>", desc = "go to next git hunk" },
        {"ghp", "<cmd>Gitsigns prev_hunk<CR>", desc = "go to previous git hunk" },
        {"ghP", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "preview git hunk inline" },
        {"ghc", "<cmd>Gitsigns stage_hunk<CR>", desc = "stage current hunk for commit" },
        {"ghC", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "unstage current hunk for commit" },
        {"ghr", "<cmd>Gitsigns reset_hunk<CR>", desc = "restore current hunk" },
        {"ghb", "<cmd>Gitsigns blame<CR>", desc = "full file blame"},
    }
}
