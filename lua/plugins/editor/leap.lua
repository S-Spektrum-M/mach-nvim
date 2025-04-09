return {
    'ggandor/leap.nvim',
    keys = { "s", "S" },       -- or whatever keys you mapped it to
    config = function()
        require('leap').add_default_mappings()
    end,
}
