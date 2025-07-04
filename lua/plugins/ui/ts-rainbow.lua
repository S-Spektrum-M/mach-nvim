return {
    'HiPhish/rainbow-delimiters.nvim',
    event = "BufReadPost",
    config = function()
        vim.g.rainbow_delimiters = vim.mach_opts.ts_rainbow
    end
}
