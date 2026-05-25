local exe_name = require('mach.lsp_util').exe_name

local default_config = {
    cmd = {
        exe_name('clangd'),
        '--clang-tidy' ,
        '--query-driver=/bin/g++'
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = { '.git', '.clang-format', 'CMakeLists.txt', 'Makefile' },
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
