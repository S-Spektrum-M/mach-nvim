return
{
    'sindrets/diffview.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'vim-fugitive'
    },
    keys = {
        {"<Leader>do", "<cmd>DiffviewOpen<CR>", desc = "Open diff view"},
        {"<Leader>dc", "<cmd>DiffviewClose<CR>", desc = "Close diff view"},
    }
}
