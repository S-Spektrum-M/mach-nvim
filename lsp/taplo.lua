local exe_name = require('mach.lsp_util').exe_name

local default_config = {
    cmd = { exe_name('taplo'), 'lsp', 'stdio' },
    filetypes = { 'toml' },
    root_markers = { '.taplo.toml', 'taplo.toml', '.git' },
    on_attach = function(client, bufnr)
        require("nvim-navic").attach(client, bufnr)
    end,
    single_file_support = true
}

return default_config
