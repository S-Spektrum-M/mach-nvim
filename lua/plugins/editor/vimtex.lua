return {
    'lervag/vimtex',
    tag = "v2.14",
    config = function ()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_method = 'latexmk'
    end,
    ft = {'tex', 'latex'},
}
