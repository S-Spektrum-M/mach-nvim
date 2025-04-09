local indent_conf = {
    enabled = true,
    char = "│",
    animate = { enabled = false },
}

local statuscolumn_conf = {
    -- default config but with open fold statuscolumn sign
    enabled = true,
    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
    right = { "fold", "git" }, -- priority of signs on the right (high to low)
    folds = {
        open = true,           -- show open fold icons
        git_hl = false,        -- use Git Signs hl for fold icons
    },
    -- patterns to match Git signs
    git = { patterns = { "GitSign", "MiniDiffSign" }, },
    refresh = 100,

}


return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        indent = indent_conf,
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        picker = { enabled = false },
        statuscolumn = statuscolumn_conf,
        words = { enabled = false },
    },
}
