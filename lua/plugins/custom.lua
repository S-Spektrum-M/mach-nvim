-- this is where you can specify your own plugins
return {
    -- example:
    -- {
    --     "S-Spektrum-M/odyssey.nvim",
    --     lazy = true,
    --     priority = 1000,
    -- }
    {
        'lervag/vimtex',
        tag = "v2.14",
        config = function()
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_compiler_method = 'latexmk'
        end,
        ft = { "tex", "latex", "cls", "tikz" }, -- defer ftdetect
    }
}
