-- MIT License – see LICENSE or https://opensource.org/licenses/MIT

local nvim_ver = vim.version()
local mach_major, mach_minor, mach_patch = 1, 2, 4
local mach_ver = ("%d.%d.%d"):format(mach_major, mach_minor, mach_patch)

--[[
ASCII art from: asciiart.website/index.php?art=transportation/airplanes
Retrieved on: [2025-04-11]
No explicit license or author information was provided.
If you are the original artist and want this removed or credited differently,
please reach out.
]]

local HEADER_CONTENT = {
    [[                        █▀▄▀█ ▄▀█ █▀▀ █░█                        ]],
    [[                 .      █░▀░█ █▀█ █▄▄ █▀█      .                 ]],
    [[                //                             \\                ]],
    ("               //             %s             \\\\               "):format(mach_ver),
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
        pick = nil,
        keys = {
            { icon = "", desc = "Find File", action = function () Snacks.dashboard.pick('files') end, key = "p" },
            { icon = " ", desc = "New File", action = ":enew", key = "n" },
            { icon = "", desc = "Terminal", action = function () Snacks.terminal.toggle() end, key = "t" },
            { icon = "", desc = "Recent Files", action = function () Snacks.dashboard.pick('oldfiles') end, key = "r" },
            { icon = "󰒲 ", desc = "Update", action = ":Update", key = "u" },
            { icon = " ", desc = "Quit", action = ":qa", key = "q" },
        },
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

local snacks_input = {
    enabled = true,
    char = "│",
    win = {
        relative = "cursor",
        row = -3,
        col = 0,
    }
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
    refresh = 10,
}

local snacks_picker = {
    layout = 'telescope',
    layouts = {},

}

local snacks_terminal = {
    enabled = true,
    win = {
        style = "terminal",
        position = "float",
        width = 0.7,
        height = 0.7,
        border = "rounded",
    },
}


return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- let's have this seperate for now
    -- TODO: move to integrated config
    opts = {
        bigfile = { enabled = true },
        dashboard = snacks_dashboard,
        indent = snacks_indent,
        input = snacks_input,
        notifier = { enabled = true },
        quickfile = { enabled = true },
        picker = snacks_picker,
        statuscolumn = snacks_statuscolumn,
        terminal = snacks_terminal,
        words = { enabled = false },
    },
    keys = {
        -- snacks picker
        { "<C-p>",         function() Snacks.picker.files() end,                 desc = "Find Files" },
        { "<C-r>",         function() Snacks.picker.grep() end,                  desc = "Live Grep" },
        { "<C-b>",         function() Snacks.picker.buffers() end,               desc = "Buffers" },
        { "<Leader><C-p>", function() Snacks.picker.commands() end,              desc = "Commands" },
        { "<Leader>gl",    function() Snacks.picker.git_log() end,               desc = "Git Commits Log" },
        { "<Leader>st",    function() Snacks.picker.lsp_workspace_symbols() end, desc = "Lsp Document Symbols" }, -- st  for  symbol  tree
        { "gd",            function() Snacks.picker.lsp_definitions() end,       desc = "Go to Lsp Defintion" },
        -- snacks terminal
        -- In my actual workflow if I ever need more than 1 terminal, I just
        -- use tmux, so I won't port all of the floaterm keybinds until later
        {
            '<F12>', function() Snacks.terminal.toggle() end, desc = "Toggle Floaterm Window", mode = { 'n', 't' }
        },
    },
}
