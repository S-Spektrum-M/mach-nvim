local M = {}

local function get_fd_cache_path()
    local work_dir = vim.fn.getcwd()
    local cache_file = vim.fs.normalize(work_dir):gsub('[:/\\]', '-'):gsub('^-', '') .. '.fd'
    return vim.fs.joinpath(vim.fn.stdpath('state'), cache_file)
end

local function cache_file(callback)
    local cache_path = get_fd_cache_path()
    local cache, err = io.open(cache_path, 'w')
    if err ~= nil or cache == nil then
        vim.notify(err, vim.log.levels.ERROR)
        return
    end

    callback(cache)

    cache:close()
end

M.init_fd_cache = function()
    cache_file(function(f)
        local result = vim.system({ 'fd', '--type', 'file' }, { text = true, cwd = vim.fn.getcwd() }):wait()

        if result.code ~= 0 then
            vim.notify("fd failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
            return
        end

        for line in result.stdout:gmatch('([^\n]*)\n?') do
            if line ~= '' then
                f:write(line, '\n')
            end
        end
    end)
    vim.notify("fd cache initialized", vim.log.levels.INFO)
end

M.clear_fd_cache = function()
    local path = get_fd_cache_path()
    if vim.fn.filereadable(path) == 1 then
        os.remove(path)
        vim.notify("fd cache cleared", vim.log.levels.INFO)
    else
        vim.notify("No fd cache to clear", vim.log.levels.INFO)
    end
end

M.list_files = function()
    local cache_path = get_fd_cache_path()
    if vim.fn.filereadable(cache_path) == 0 then
        vim.notify("fd cache not found. Run InitFdCache first.", vim.log.levels.WARN)
        return
    end

    local items = {}
    for line in io.lines(cache_path) do
        table.insert(items, {
            text = line,
            file = line,
        })
    end

    require('snacks').picker({
        items = items,
        title = "Cached Files",
        format = "file",
        on_select = function(item)
            if item and item.file then
                vim.cmd('edit ' .. item.file)
            end
        end,
    })
end

return M
