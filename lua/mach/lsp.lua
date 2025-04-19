local diag_config1 = {
    virtual_text = { enabled = true, severity = { max = vim.diagnostic.severity.WARN, }, },
    virtual_lines = { enabled = true, severity = { min = vim.diagnostic.severity.ERROR, }, },
}

local diag_config2 = { virtual_text = true, virtual_lines = false, }

vim.diagnostic.config(diag_config2)
local diag_config_basic = false

local function switch_lsp_diag_mode()
    diag_config_basic = not diag_config_basic
    vim.diagnostic.config(diag_config_basic and diag_config1 or diag_config2)
end

local maps = {
    { "n", "gD",           vim.lsp.buf.declaration,                       { noremap = true, desc = "Go to declaration" } },
    { "n", "K",            vim.lsp.buf.hover,                             { noremap = true, desc = "Hover Insights", } },
    { "n", "gi",           vim.lsp.buf.implementation,                    { noremap = true, desc = "Go to implementation", } },
    { "n", "gR",           vim.lsp.buf.code_action,       { noremap = true, desc = "Refactor", } },
    { "n", "<leader><F2>", vim.lsp.buf.format,                            { noremap = true, desc = "Format buffer" } },
    { "n", "gK",           switch_lsp_diag_mode,                          { noremap = true, desc = "Toggle diagnostic virtual_lines" } },
    { "n", "gr",           function() Snacks.picker.lsp_references() end, { noremap = true, desc = "Go to References", } }, -- this needs to be in function ... end syntax bc Snakcks can't be indexed
}

for _, map_elem in ipairs(maps) do
    vim.keymap.set(unpack(map_elem))
end

local servers = {
    "bashls",
    "neocmake",
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
    "harper-ls",
}

vim.lsp.enable(servers)
