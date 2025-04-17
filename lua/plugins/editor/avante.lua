vim.api.nvim_create_autocmd("FileType", {
    pattern = { "Avante", "AvanteInput", "AvanteSelectedFiles" },
    callback = function()
        vim.schedule(function()
            vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true })
        end)
    end
})

return {
    "yetone/avante.nvim",
    -- Never set this value to "*"! Never!
    version = false,
    --- @see lua/mach/user-plugin-opts
    opts = vim.mach_opts.avante,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",

    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        {
            "HakonHarnes/img-clip.nvim",
            opts = vim.mach_opts.img_clip,
            ft = { 'markdown', 'tex' },
        },
        'MeanderingProgrammer/render-markdown.nvim',
    },
    keys = {
        { "<leader>aa", "<CMD>AvanteAsk<CR>", desc = "Avante", mode = { 'n', 'v' }, },
        { "<leader>ae", "<CMD>AvanteEdit<CR>", desc = "Avante", mode = { 'n', 'v' }, },
        { "<leader>at", "<CMD>AvanteToggle<CR>", desc = "Avante", mode = { 'n', 'v' }, },
        { "<leader>af", "<CMD>AvanteFocus<CR>", desc = "Avante", mode = { 'n', 'v' }, },
        { "<leader>a?", "<CMD>AvanteModels<CR>", desc = "Avante", mode = { 'n', 'v' }, },
    }
}
