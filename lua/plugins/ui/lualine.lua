local lsp_loc = function()
    local file_name = vim.fn.expand('%')
    local parts = {}
    for part in string.gmatch(file_name, "[^/]+") do
        table.insert(parts, part)
    end
    for i = 1, #parts - 1 do
        parts[i] = parts[i]:sub(1, 1)
    end
    local file = table.concat(parts, "/")

    if vim.lsp.buf_is_attached(0) and require('nvim-navic').is_available() then
        local loc = require('nvim-navic').get_location()
        if #loc ~= 0 then
            return file .. " > " .. loc
        end
    end

    return file
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
                        'branch',
                        'diff'
                    },
                    lualine_c = { lsp_loc },
                    lualine_z = {
                        'progress',
                        { 'location', separator = { right = '' }, left_padding = 2 },
                    },
                },
            })
        end, 50)
    end,
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
}
