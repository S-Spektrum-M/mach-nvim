local exe_name = require('mach.lsp_util').exe_name

local default_config = {
    cmd = { exe_name('deno'), 'lsp' },
    cmd_env = { NO_COLOR = true },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_dir = function(fname)
        return vim.fs.root(fname, { '.git' })
    end,
    settings = {
        deno = {
            enable = true,
            suggest = {
                imports = {
                    hosts = {
                        ['https://deno.land'] = true,
                    },
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
