local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

default_config = {
    cmd = { exe_name('lua-language-server') },
    filetypes = { 'lua' },
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}

return default_config
