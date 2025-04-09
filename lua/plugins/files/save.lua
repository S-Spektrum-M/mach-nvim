return {
    '907th/vim-auto-save',
    config = function()
        vim.g.auto_save_silent = 1
        vim.g.auto_save = 1
    end,
    event = {'TextChanged', 'InsertLeave'}
}
