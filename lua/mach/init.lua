require("mach.user-plugin-opts") -- We need to ensure that this is loaded BEFORE plugins module
require("mach.opts")
require("mach.commands")
require("mach.features")
require("mach.keymaps")
require("mach.functions")
require("mach.autocommands")

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("MachLspSetup", { clear = true }),
    once = true,
    callback = function()
        require("mach.lsp")
    end,
})
