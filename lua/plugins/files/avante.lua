return {
    "yetone/avante.nvim",
    -- event = "Keypress",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        -- add any opts here
        auto_suggestions_provider = "ollama",
        provider = "openai",
        openai = {
            endpoint = "https://api.openai.com/v1",
            model = "o3-mini",        -- your desired model (or use gpt-4o, etc.)
            timeout = 30000,          -- Timeout in milliseconds, increase this for reasoning models
            temperature = 0,
            max_tokens = 32768,       -- Increase this to include reasoning tokens (for reasoning models)
            reasoning_effort = "low", -- low|medium|high, only used for reasoning models
        },
        ollama = {
            model = "mistral:latest",
        },
        behaviour = {
            auto_suggestions = true, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true,                        -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true,                -- Whether to enable token counting. Default to true.
            enable_cursor_planning_mode = false,         -- Whether to enable Cursor Planning Mode. Default to false.
            enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
        },
        file_selector = { provider = "native", },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            -- event = "VeryLazy",
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
            ft = { 'markdown', 'tex' },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
    keys = {
<<<<<<< HEAD
        { "<leader>a", desc = "Avante", mode = {'n', 'v'}},
||||||| 183079f
        { "<leader>a", desc = "Avante", },
=======
        { "<leader>a", desc = "Avante", mode = {'n', 'v'}, },
>>>>>>> 10c16e26dacbc3acbfa5a0b4e852731571256694
    }
}
