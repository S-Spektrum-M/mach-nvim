return {
    'saghen/blink.cmp',
    -- use a release tag to download pre-built binaries
    version = '1.*',

    dependencies = {
        'Kaiser-Yang/blink-cmp-avante',
        "giuxtaposition/blink-cmp-copilot",
    },

    event = "InsertEnter",

    opts = vim.mach_opts.blink,
    opts_extend = { "sources.default" }
}
