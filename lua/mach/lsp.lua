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

local M = {}
local jump_stack = {}

local function current_location()
    return {
        bufnr = vim.api.nvim_get_current_buf(),
        filename = vim.api.nvim_buf_get_name(0),
        cursor = vim.api.nvim_win_get_cursor(0),
    }
end

local function same_location(left, right)
    return left.bufnr == right.bufnr
        and left.cursor[1] == right.cursor[1]
        and left.cursor[2] == right.cursor[2]
end

local function push_location()
    local location = current_location()
    local top = jump_stack[#jump_stack]

    if not top or not same_location(top, location) then
        table.insert(jump_stack, location)
        return true
    end

    return false
end

function M.navigate(callback)
    local pushed = push_location()

    local ok, err = pcall(callback)
    if not ok then
        if pushed then
            table.remove(jump_stack)
        end
        error(err)
    end
end

function M.go_back()
    local location = table.remove(jump_stack)
    if not location then
        vim.notify("LSP jumplist is empty", vim.log.levels.INFO)
        return
    end

    if vim.api.nvim_buf_is_valid(location.bufnr) then
        vim.api.nvim_set_current_buf(location.bufnr)
    elseif location.filename ~= "" and vim.fn.filereadable(location.filename) == 1 then
        vim.cmd.edit(vim.fn.fnameescape(location.filename))
    else
        vim.notify("The jumplist buffer is no longer available", vim.log.levels.WARN)
        return
    end

    vim.api.nvim_win_set_cursor(0, location.cursor)
end

function M.show_jumplist()
    if #jump_stack == 0 then
        vim.notify("LSP jumplist is empty", vim.log.levels.INFO)
        return
    end

    local items = {}
    for index = #jump_stack, 1, -1 do
        local location = jump_stack[index]
        local bufnr = vim.api.nvim_buf_is_valid(location.bufnr) and location.bufnr or nil
        local filename = location.filename ~= "" and location.filename or nil

        if bufnr or filename then
            table.insert(items, {
                buf = bufnr,
                file = filename,
                pos = location.cursor,
                text = filename or "[No Name]",
            })
        end
    end

    Snacks.picker({
        title = "LSP Jumplist",
        items = items,
        format = "file",
        preview = "file",
        main = { current = true },
    })
end

local maps = {
    { "n", "gD",           function() M.navigate(vim.lsp.buf.declaration) end, { noremap = true, desc = "Go to declaration" } },
    { "n", "K",            vim.lsp.buf.hover,                             { noremap = true, desc = "Hover Insights", } },
    { "n", "gi",           function() M.navigate(vim.lsp.buf.implementation) end, { noremap = true, desc = "Go to implementation", } },
    { "n", "gR",           vim.lsp.buf.code_action,       { noremap = true, desc = "Refactor", } },
    { "n", "<leader>2",     vim.lsp.buf.format,                            { noremap = true, desc = "Format buffer" } },
    { "n", "gK",           switch_lsp_diag_mode,                          { noremap = true, desc = "Toggle diagnostic virtual_lines" } },
    { "n", "gr",           function() M.navigate(function() Snacks.picker.lsp_references() end) end, { noremap = true, desc = "Go to References", } }, -- this needs to be in function ... end syntax bc Snakcks can't be indexed
    { "n", "gb",           M.go_back,                                     { noremap = true, desc = "Go back in LSP jumplist" } },
    { "n", "gJ",           M.show_jumplist,                               { noremap = true, desc = "Show LSP jumplist" } },
}

for _, map_elem in ipairs(maps) do
    vim.keymap.set(unpack(map_elem))
end

vim.api.nvim_create_user_command("Jumplist", M.show_jumplist, { nargs = 0 })
vim.api.nvim_create_user_command("JumplistBack", M.go_back, { nargs = 0 })

local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
local servers = {}
local scan = vim.loop.fs_scandir(lsp_dir)
if scan then
    while true do
        local name, t = vim.loop.fs_scandir_next(scan)
        if not name then break end
        if t == "file" and name:match("%.lua$") then
            table.insert(servers, (name:gsub("%.lua$", "")))
        end
    end
end

vim.lsp.enable(servers)

return M
