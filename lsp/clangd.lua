local exe_name = require('mach.lsp_util').exe_name

local nproc = tonumber (vim.fn.system ({"nproc"}))

-- Credit: https://gasparvardanyan.github.io/blog/tips-for-cpp-developers/
if 0 ~= nproc
then
    local jnproc =  "--j=" .. (nproc - 1)
end

local default_config = {
    cmd = {
        exe_name('clangd'),
        '--clang-tidy',
        '--query-driver=/bin/g++',
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
