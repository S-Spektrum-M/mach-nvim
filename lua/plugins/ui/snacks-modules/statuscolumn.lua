return {
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
