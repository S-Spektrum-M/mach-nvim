return {
    -- {
    --     "S-Spektrum-M/odyssey.nvim",
    --     event = 'ColorSchemePre',
    --     config = function()
    --         require('odyssey').setup('odyssey')
    --     end
    -- },
    {
        dir = "~/projects/config/obsidian.nvim/",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme obsidian")
        end
    }
}
