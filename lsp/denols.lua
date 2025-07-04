local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

default_config = {
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
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
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
