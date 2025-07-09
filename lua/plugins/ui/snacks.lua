return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = vim.mach_opts.snacks,
    keys = {
        -- snacks picker
        {
            "<C-p>",
            function() Snacks.picker.files() end,
            desc = "Find Files"
        },
        {
            "<C-r>",
            function() Snacks.picker.grep() end,
            desc = "Live Grep"
        },
        {
            "<C-b>",
            function() Snacks.picker.buffers() end,
            desc = "Buffers"
        },
        {
            "<Leader><C-p>",
            function() Snacks.picker.commands() end,
            desc = "Commands"
        },
        {
            "<Leader>gl",
            function() Snacks.picker.git_log() end,
            desc = "Git Commits Log"
        },
        {
            "<Leader>st", -- st  for  symbol  tree
            function() Snacks.picker.lsp_workspace_symbols() end,
            desc = "Lsp Document Symbols"
        },
        {
            "gd",
            function() Snacks.picker.lsp_definitions() end,
            desc = "Go to Lsp Defintion"
        },
        {
            "<F12>",
            function() Snacks.terminal.toggle() end,
            desc = "Toggle Floaterm Window",
            mode = { 'n', 't' }
        },
    },
}
