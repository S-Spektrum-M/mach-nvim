local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

default_config = {
    cmd = { exe_name('pylsp') },
    filetypes = { 'python' },
    rootmarkers = {'__pycache__', },
    single_file_support = true,
}

return default_config
