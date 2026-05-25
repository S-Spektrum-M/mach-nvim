local default_config = {
    cmd = { vim.fn.stdpath('data') .. "/mason/bin/rust-analyzer" },
    root_dir = function(fname)
        return vim.fs.root(fname, { '.git' })
    end,
    root_markers = {'cargo.toml', },
    filetypes = { 'rust', },
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
