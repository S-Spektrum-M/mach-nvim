return {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        vim.defer_fn(function()
            require('lualine').setup(vim.mach_opts.lualine)
        end, 50)
    end,
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
}
