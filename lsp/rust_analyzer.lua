local default_config = {
    cmd = { vim.fn.stdpath('data') .. "/mason/bin/rust-analyzer" },
    root_dir = function(fname)
        return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
    end,
    root_markers = {'cargo.toml', },
    filetypes = { 'rust', },
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
