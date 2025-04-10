local nvim_ver = vim.version()

local HEADER_CONTENT = {
    [[                        █▀▄▀█ ▄▀█ █▀▀ █░█                        ]],
    [[                 .      █░▀░█ █▀█ █▄▄ █▀█      .                 ]],
    [[                //                             \\                ]],
    [[               //             1.2.0             \\               ]],
    ("              //        neovim     %d.%d.%d        \\\\              "):format(nvim_ver.major, nvim_ver.minor,
        nvim_ver.patch),
    [[             //                _._                \\             ]],
    [[          .---.              .//|\\.              .---.          ]],
    [[________ / .-. \_________..-~ _.-._ ~-..________ / .-. \_________]],
    [[         \ ._. /    H-     '--.___.--'     -H    \ ._. /         ]],
    [[          •---•     H          [H]          H     •---•          ]],
    [[                   _H_         _H_         _H_                   ]],
    [[                   UUU         UUU         UUU                   ]],
}

local header = ""
for _, row in ipairs(HEADER_CONTENT) do
    header = header .. row .. '\n'
end

local snacks_dashboard = {
    width = 60,
    row = nil,                                                                   -- dashboard position. nil for center
    col = nil,                                                                   -- dashboard position. nil for center
    pane_gap = 4,                                                                -- empty columns between vertical panes
    autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
    -- These settings are used by some built-in sections
    preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
            { icon = " ", desc = "New File", action = ":enew", key = "n" },
            { icon = " ", desc = "Find File", action = ":Telescope find_files", key = "p" },
            { icon = " ", desc = "Recent Files", action = ":Telescope oldfiles", key = "r" },
            { icon = "󰒲 ", desc = "Update", action = ":Update", key = "u" },
            { icon = " ", desc = "Quit", action = ":qa", key = "q" },
        },
        -- Used by the `header` section
        header = header,
    },
    sections = {
        { section = "header" },
        { section = "keys",  gap = 1, padding = 1 },
    },
}

local snacks_indent = {
    enabled = true,
    char = "│",
    animate = { enabled = false },
}

local snacks_statuscolumn = {
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
        dashboard = snacks_dashboard,
        indent = snacks_indent,
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        picker = { enabled = false },
        statuscolumn = snacks_statuscolumn,
        words = { enabled = false },
    },
}
