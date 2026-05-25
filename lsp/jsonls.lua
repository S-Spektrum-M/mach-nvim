local exe_name = require('mach.lsp_util').exe_name

local default_config = {
    cmd = { exe_name('vscode-json-language-server'), '--stdio' },
    filetypes = { 'json', 'jsonc' },
    init_options = {
        provideFormatter = true,
    },
    root_dir = function(fname)
        return vim.fs.root(fname, { '.git' })
    end,
    single_file_support = true,
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
