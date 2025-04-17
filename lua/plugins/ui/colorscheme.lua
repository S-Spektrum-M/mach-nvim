return {
    {
        "navarasu/onedark.nvim",
        event = "ColorSchemePre",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup(vim.mach_opts.onedark)
            vim.cmd.colorscheme("onedark") -- probably the least jarring theme
        end
    },
}
