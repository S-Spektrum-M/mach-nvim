local exe_name = require('mach.lsp_util').exe_name

local default_config = {
    cmd = { exe_name("lua-language-server") },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    telemetry = { enabled = false },
    formatters = {
        ignoreComments = false,
    },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            signatureHelp = { enabled = true },
        },
    },
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end

}


return default_config
