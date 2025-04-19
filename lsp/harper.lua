local function exe_name(lsp_name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. lsp_name
end

local default_config = {
    cmd = { exe_name('harper-ls') },
    filetypes = { 'markdown', 'text', 'latex', 'plaintex',  },
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
