return {
    'saghen/blink.cmp',
    -- use a release tag to download pre-built binaries
    version = '1.*',

    dependencies = {
        'Kaiser-Yang/blink-cmp-avante',
    },

    event = "InsertEnter",

    opts = {
        keymap = { preset = 'super-tab' },

        completion = {
            list = {
                selection = { preselect = true, auto_insert = true },
            },
        },
        appearance = { nerd_font_variant = 'mono' },

        sources = {
            default = { 'avante', 'lsp', 'path', 'buffer' },
            providers = {
                avante = {
                    module = 'blink-cmp-avante',
                    name = 'Avante',
                    opts = {
                        -- options for blink-cmp-avante
                    }
                }
            },

        },
        fuzzy = { implementation = "prefer_rust_with_warning" },

        enabled = function()
            local disabled = false
            disabled = disabled or (vim.tbl_contains({ "markdown" }, vim.bo.filetype))
            disabled = disabled or (vim.bo.buftype == "prompt")
            disabled = disabled or (vim.fn.reg_recording() ~= "")
            disabled = disabled or (vim.fn.reg_executing() ~= "")
            return not disabled
        end,

    },
    opts_extend = { "sources.default" }
}
