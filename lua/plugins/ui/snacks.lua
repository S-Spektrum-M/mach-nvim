return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        indent = require("plugins.ui.snacks-modules.indent"),
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        picker = { enabled = false },
        statuscolumn = require("plugins.ui.snacks-modules.statuscolumn"),
        words = { enabled = false },
    },
}
