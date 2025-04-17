return {
    "folke/which-key.nvim",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = vim.mach_opts.which_key,
    keys = { "<leader>", "<ctrl>", "z" }
}
