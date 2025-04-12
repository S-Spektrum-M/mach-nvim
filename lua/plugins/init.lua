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

-- Auto-discover plugins from subdirectories
local function load_plugin_specs_from(dir)
    local specs = {}
    local base = vim.fn.stdpath("config") .. "/lua/plugins/" .. dir
    local scan = vim.loop.fs_scandir(base)

    if scan then
        while true do
            local name, t = vim.loop.fs_scandir_next(scan)
            if not name then break end

            if t == "directory" then
                local sub_specs = load_plugin_specs_from(dir .. "/" .. name)
                vim.list_extend(specs, sub_specs)
            elseif name:match("%.lua$") and name ~= "init.lua" then
                local module = "plugins." .. dir:gsub("/", ".") .. "." .. name:gsub("%.lua$", "")
                table.insert(specs, require(module))
            end
        end
    end

    return specs
end

-- List all plugin categories
local plugin_dirs = { "editor", "files", "git", "lsp", "lsp/extensions", "terminal", "ui",
}

-- Load all plugin specs from each category
local all_specs = {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip", "zipPlugin", "tarPlugin", "netrwPlugin", "matchit",
                "matchparen", "tutor", "spellfile_plugin", "tohtml",
                "man", "rplugin", "editorconfig",
            }
        },
        cache = { enabled = true },
        reset_packpath = true,
    },
    profiling = { enabled = false },
}
for _, dir in ipairs(plugin_dirs) do
    vim.list_extend(all_specs, load_plugin_specs_from(dir))
end

vim.list_extend(all_specs, require('plugins.custom'))

-- Setup Lazy with discovered specs
require("lazy").setup(all_specs, nil)
