return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim'
    },
    config = function()
        local ts = require("telescope")

        local border_chars_none = { " ", " ", " ", " ", " ", " ", " ", " " }

        ts.setup({
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = {
                    height          = 0.85,
                    width           = 0.85,
                    prompt_position = 'top'
                },
                borderchars = {
                    prompt = border_chars_none,
                    results = border_chars_none,
                    preview = border_chars_none,
                },
                defaults = {
                    border = true,
                    prompt_prefix = '   ',
                    hl_result_eol = true,
                    results_title = "",
                    winblend = 0
                }
            },
            pickers = {
                find_files = {
                    prompt_title = "Find Files",
                },
                commands = {
                    theme = "dropdown",
                    prompt_title = "Commands",
                },
                command_history = {
                    theme = "dropdown",
                    prompt_title = "Command History",
                },
            },
            extensions = {
                --file_browser = {}, -- Use Defaults
                ["ui-select"] = { require("telescope.themes").get_dropdown {} }
            },
        })
        require("telescope").load_extension("ui-select")
    end,
    cmd = { 'Telescope', 'TodoTelescope' },
    keys = {
        { "<C-p>",         "<cmd>Telescope find_files<cr>",           desc = "Telescope Find Files" },
        { "<C-r>",         "<cmd>Telescope live_grep<cr>",            desc = "Telescope Live Grep" },
        { "<C-b>",         "<cmd>Telescope buffers<cr>",              desc = "Telescope Buffers" },
        { "<Leader><C-p>", "<cmd>Telescope commands<cr>",             desc = "Telescope Command Prompt" },
        { "<Leader>gl",    "<cmd>Telescope git_commits<cr>",          desc = "Telescope Git Commits Log" },
        { "<Leader>ds",    "<cmd>Telescope lsp_document_symbols<cr>", desc = "Telescope Lsp Document Symbols" },
        { "gd",            "<cmd>Telescope lsp_definitions<cr>",      desc = "Go to lsp_definition" },

    },
}
