local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

local default_config = {
    cmd = { exe_name('neocmakelsp'), '--stdio' },
    filetypes = { 'cmake' },
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    single_file_support = true,
}

return default_config
