local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

default_config = {
    cmd = { exe_name('clangd'), '--clang-tidy' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = { '.git', '.clang-format', 'CMakeLists.txt', 'Makefile' },
}

return default_config
