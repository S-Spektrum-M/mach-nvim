return {
    "numToStr/Comment.nvim",
    -- event = { "ModeChanged" },
    config = function () require('Comment').setup() end,
    lazy = true,
    opts = vim.mach_opts.comment,
    keys = {'gc', 'gb'}
}
