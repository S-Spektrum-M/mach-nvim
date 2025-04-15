return {
    "numToStr/Comment.nvim",
    event = { "ModeChanged" },
    config = function ()
        require('Comment').setup()
    end,
    opts = {
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
            line = 'gcc', ---Line-comment toggle keymap
            block = 'gbc', ---Block-comment toggle keymap
        },
        opleader = {
            line = 'gc',
            block = 'gb',
        },
        extra = {
            above = 'gcO', ---Add comment on the line above
            below = 'gco', ---Add comment on the line below
            eol = 'gcA', ---Add comment at the end of line
        },
        mappings = {
            basic = true,
            extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
    },
    lazy = true,
}
