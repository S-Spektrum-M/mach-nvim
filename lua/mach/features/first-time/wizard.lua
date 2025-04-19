local function plugin_setup()
    local avante_conf = require('mach.features.first-time.plugin-wizards.avante')()
    return {avante_conf}
end

return function()
    -- Mark the beginning of the wizard for clarity
    vim.notify("Welcome! Running first-time setup.", vim.log.levels.INFO, { title = "Neovim Setup" })
    plugin_setup()
    vim.notify("First-time setup complete!", vim.log.levels.INFO, { title = "Neovim Setup" })
end
