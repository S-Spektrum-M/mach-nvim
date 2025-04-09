local diag_config1 =
{
    virtual_text =
        {
            enabled = true,
            severity =
                {
                    max = vim.diagnostic.severity.WARN,
                },
        },
    virtual_lines =
        {
            enabled = true,
            severity =
                {
                    min = vim.diagnostic.severity.ERROR,
                },
        },
} local diag_config2 =
{
    virtual_text = true,
    virtual_lines = false,
} vim.diagnostic.config(diag_config2) local diag_config_basic = false

local map =
vim.keymap.set

map("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>",
    {noremap = true, desc = "Go to declaration"})

map("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>",
    {
        noremap = true,
        desc = "Hover Insights",
    })

map("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>",
    {
        noremap = true,
        desc = "Go to implementation",
    })

map("n", "gr", "<CMD>Telescope lsp_references<CR>",
    {
        noremap = true,
        desc = "Go to References",
    })

map("n", "gR", "<CMD>lua vim.lsp.buf.code_action({refactor})<CR>", { noremap = true, desc = "Refactor", })

map("n", "gK",
    function() diag_config_basic =
        not diag_config_basic if diag_config_basic
        then vim.diagnostic
            .config(
                diag_config1) else vim
            .diagnostic.config(
                diag_config2) end end,
    {noremap = true,
        desc = "Toggle diagnostic virtual_lines"})

local servers = {
    "bashls",
    "cmake",
    "clangd",
    "denols",
    "gopls",
    "jsonls",
    "lua_ls",
    "pylsp",
    "rust_analyzer",
    "taplo",
    "texlab",
    "yamlls",
    "zls",
}

for _, server in ipairs(servers) do
    vim.defer_fn(function() vim.lsp.enable(server) end, 0)
end
