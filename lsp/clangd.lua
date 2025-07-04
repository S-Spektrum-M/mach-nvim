local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

local default_config = {
    cmd = {
        'clangd',
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
