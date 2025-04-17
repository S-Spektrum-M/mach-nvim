return {
    "numToStr/Comment.nvim",
    event = { "ModeChanged" },
    config = function ()
        require('Comment').setup()
    end,
    opts = vim.mach_opts.comment,
    lazy = true,
}
