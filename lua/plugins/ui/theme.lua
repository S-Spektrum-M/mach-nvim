return {
    {
        -- "nyoom-engineering/oxocarbon.nvim"
    },
    -- "navarasu/onedark.nvim",
    {
        "S-Spektrum-M/odyssey.nvim",
        event = 'ColorSchemePre',
        config = function()
            require('odyssey').setup('odyssey')
        end
    },
}
