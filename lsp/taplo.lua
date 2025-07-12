local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

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
