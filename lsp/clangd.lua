local exe_name = require('mach.lsp_util').exe_name

local nproc = tonumber(vim.trim(vim.fn.system({ "nproc" })))
-- Use half of the available processors for clangd indexing.
local jnproc = (nproc and nproc > 0) and ("--j=" .. math.floor(nproc / 2)) or nil

local default_config = {
    cmd = {
        exe_name('clangd'),
        '--clang-tidy',
        '--background-index',
        jnproc,
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = { '.git', '.clang-format', 'CMakeLists.txt', 'Makefile' },
    on_attach = function(client, bufnr)
        local navic = require("nvim-navic")
        navic.attach(client, bufnr)
    end
}

return default_config
