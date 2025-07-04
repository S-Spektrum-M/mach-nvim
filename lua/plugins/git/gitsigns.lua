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
        {"ghn", "<cmd>Gitsigns next_hunk<CR>"},
        {"ghp", "<cmd>Gitsigns prev_hunk<CR>"},
        {"ghP", "<cmd>Gitsigns preview_hunk_inline<CR>"},
        {"ghc", "<cmd>Gitsigns stage_hunk<CR>"},
        {"ghC", "<cmd>Gitsigns undo_stage_hunk<CR>"},
    }
}
