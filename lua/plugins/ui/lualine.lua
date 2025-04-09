return {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    config = function()
        vim.defer_fn(function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {},
                    always_divide_middle = true,
                },
                sections = {
                    lualine_a = {
                        { 'mode', separator = { left = '' }, right_padding = 2},
                        'diagnostics',
                    },
                    lualine_b = {
                        'filename',
                        'branch',
                        'diff'
                    },
                    lualine_z = {
                        'progress',
                        { 'location', separator = { right = '' }, left_padding = 2},
                    },
                },
            })
        end, 50)
    end
}
