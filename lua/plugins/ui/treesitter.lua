return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate" },
    config = function()
        vim.defer_fn(function()
            require("nvim-treesitter.configs").setup(vim.mach_opts.treesitter)
        end, 20) -- delay to avoid blocking BufReadPost
    end,
}
