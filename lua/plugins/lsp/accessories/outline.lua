return {
    'simrat39/symbols-outline.nvim',
    config = function () require("symbols-outline").setup({
        relative_width = true,
        width = 20
    }) end,
    cmd = 'SymbolsOutline',
    keys = {
        {'<Leader>st', '<cmd>SymbolsOutline<CR>'}
    }
}
