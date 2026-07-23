local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugin_specs = {
    { import = "plugins.dap" },
    { import = "plugins.editor" },
    { import = "plugins.files" },
    { import = "plugins.git" },
    { import = "plugins.lsp" },
    { import = "plugins.terminal" },
    { import = "plugins.ui" },
}

local lazy_opts = {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip", "zipPlugin", "tarPlugin", "matchit", "matchparen", "tutor", "spellfile_plugin", "tohtml",
                "rplugin", "editorconfig",
            }
        },
        cache = { enabled = true },
        reset_packpath = true,
    },
    profiling = { enabled = false },
}

require("lazy").setup(plugin_specs, lazy_opts)
