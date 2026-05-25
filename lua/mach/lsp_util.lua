local M = {}

function M.exe_name(name)
    return vim.fn.stdpath('data') .. '/mason/bin/' .. name
end

return M
