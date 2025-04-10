local winbar_symbol = function()
    if vim.lsp.buf_is_attached(0) and require('nvim-navic').is_available() then
        local loc = require('nvim-navic').get_location()
        local padding = string.rep(' ', (vim.api.nvim_win_get_width(0) - #loc) / 2)
        -- autocenter
        return padding .. loc .. padding
    end

    return ''
end

return {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        vim.defer_fn(function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {},
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = {
                        { 'mode', separator = { left = '' }, right_padding = 2 },
                        'diagnostics',
                    },
                    lualine_b = {
                        'filename',
                        'branch',
                        'diff'
                    },
                    lualine_z = {
                        'progress',
                        { 'location', separator = { right = '' }, left_padding = 2 },
                    },
                },
                winbar = {
                    lualine_c = { winbar_symbol },
                },
            })
        end, 50)
    end,
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
}
