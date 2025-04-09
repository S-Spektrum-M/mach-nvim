return {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre" },
    config = function()
        require('gitsigns').setup {
            signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked          = false,
            current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil, -- Use default
            max_file_length              = 40000,
            preview_config               = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            }
        }
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'vim-fugitive',
    },
    keys = {
        {"ghn", "<cmd>Gitsigns next_hunk<CR>"},
        {"ghp", "<cmd>Gitsigns prev_hunk<CR>"},
        {"ghP", "<cmd>Gitsigns preview_hunk_inline<CR>"},
        {"ghc", "<cmd>Gitsigns stage_hunk<CR>"},
        {"ghC", "<cmd>Gitsigns undo_stage_hunk<CR>"},
    }
}
