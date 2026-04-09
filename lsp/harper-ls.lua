local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

local default_config = {
    cmd = { exe_name('harper-ls'), '--stdio' },
    filetypes = { 'markdown', 'text', 'latex', 'plaintex',  },
}

return default_config
