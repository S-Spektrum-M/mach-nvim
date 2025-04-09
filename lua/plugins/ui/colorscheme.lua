return {
    {
        "EdenEast/nightfox.nvim",
        event = "ColorSchemePre",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme carbonfox")
        end
    },
}
