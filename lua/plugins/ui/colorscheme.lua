return {
    {
        "S-Spektrum-M/blackbird.nvim",
        event = "ColorSchemePre",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("blackbird")
        end
    },
}
