local exe_name = require('mach.lsp_util').exe_name

local default_config = {
    cmd = { exe_name('neocmakelsp'), '--stdio' },
    filetypes = { 'cmake' },
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    single_file_support = true,
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
