return {
    'voldikss/vim-floaterm',
    cmd = { 'FloatermNew', 'FloatermToggle', },
    keys = {
        {
            '<F7>',
            '<cmd>FloatermNew<CR>',
            desc = "New Floaterm Window",
            mode = { 'n', 't' }
        },
        {
            '<F8>',
            '<cmd>FloatermPrev<CR>',
            desc = "Previous Floaterm Window",
            mode = { 'n', 't' }
        },
        {
            '<F9>',
            '<cmd>FloatermNext<CR>',
            desc = "Next Floaterm Window",
            mode = { 'n', 't' }
        },
        {
            '<F12>',
            '<cmd>FloatermToggle<CR>',
            desc = "Toggle Floaterm Window",
            mode = { 'n', 't' }
        },
    }
}
