return {
    {
        "navarasu/onedark.nvim",
        event = "ColorSchemePre",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup({
                style = "darker",
                code_style = { comments = 'none', },
            })
            vim.cmd.colorscheme("onedark") -- probably the least jarring theme
        end
    },
}
