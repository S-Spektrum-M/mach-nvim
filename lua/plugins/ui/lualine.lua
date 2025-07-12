return {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        vim.defer_fn(function()
            require('lualine').setup(vim.mach_opts.lualine)
            if os.getenv("TMUX") then
                vim.opt.laststatus = 0
                vim.api.nvim_set_hl(0, 'StatusLine', { link = 'Normal' })
                vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'Normal' })
                vim.opt.statusline = '%{repeat("─",winwidth("."))} ' -- Added a space at the end for consistency
            end
        end, 50)
    end,
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
        {
            "vimpostor/vim-tpipeline",
            config = function()
                vim.g.tpipeline_autoembed = 1
            end,
        },
    },
}
