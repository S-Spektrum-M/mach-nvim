local status_highlights = {
    ['?'] = 'SnacksPickerUntracked',
    A = 'SnacksPickerAdded',
    C = 'SnacksPickerRenamed',
    D = 'SnacksPickerDeleted',
    M = 'SnacksPickerModified',
    R = 'SnacksPickerRenamed',
    T = 'SnacksPickerModified',
    U = 'SnacksPickerOrphaned',
}

local conflict_statuses = {
    AA = true,
    AU = true,
    DD = true,
    DU = true,
    UA = true,
    UD = true,
    UU = true,
}

local function display_status(status)
    if conflict_statuses[status] then
        return 'U', status_highlights.U
    end

    if status == '??' then
        return '?', status_highlights['?']
    end

    for _, code in ipairs({ 'D', 'R', 'C', 'A', 'M', 'T' }) do
        if status:find(code, 1, true) then
            return code, status_highlights[code]
        end
    end

    return vim.trim(status), 'SnacksPickerDefault'
end

local function build_items(output, cwd)
    local entries = vim.split(output, '\0', { plain = true, trimempty = true })
    local items = {}
    local entry_index = 1

    while entry_index <= #entries do
        local entry = entries[entry_index]
        local status = entry:sub(1, 2)
        local path = entry:sub(4)
        local text = path

        -- With porcelain v1's -z format, renames and copies are emitted as
        -- "destination\0source\0" instead of "source -> destination".
        if status:find('[RC]') then
            local source = entries[entry_index + 1]
            if source then
                text = source .. ' -> ' .. path
                entry_index = entry_index + 1
            end
        end

        local absolute_path = vim.fs.normalize(vim.fs.joinpath(cwd, path))
        items[#items + 1] = {
            idx = #items + 1,
            score = #items + 1,
            text = text,
            status = status,
            file = absolute_path,
            is_directory = vim.fn.isdirectory(absolute_path) == 1,
        }

        entry_index = entry_index + 1
    end

    return items
end

local function open_picker(items)
    require('snacks').picker({
        items = items,
        format = function(item)
            local code, status_hl = display_status(item.status)
            local text_hl = item.is_directory and 'SnacksPickerDirectory' or 'SnacksPickerPath'

            return {
                { '[' .. code .. ']', status_hl },
                { ' ' .. item.text, text_hl },
            }
        end,
        on_select = function(item)
            if not item or not item.file then
                return
            end

            if vim.uv.fs_stat(item.file) == nil then
                vim.notify('Cannot open a deleted file: ' .. item.text, vim.log.levels.WARN)
                return
            end

            local ok, err = pcall(vim.cmd.edit, vim.fn.fnameescape(item.file))
            if not ok then
                vim.notify('Cannot open ' .. item.text .. ': ' .. tostring(err), vim.log.levels.WARN)
            end
        end,
    })
end

local function git_st()
    local cwd = vim.fn.getcwd()

    vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { cwd = cwd, text = true }, function(root_result)
        if root_result.code ~= 0 then
            vim.schedule(function()
                local message = vim.trim(root_result.stderr or '')
                vim.notify(message ~= '' and message or 'Not inside a Git repository', vim.log.levels.WARN)
            end)
            return
        end

        local root = vim.trim(root_result.stdout)
        vim.system({
            'git',
            '--no-optional-locks',
            'status',
            '--porcelain=v1',
            '-z',
            '--untracked-files=all',
        }, { cwd = root }, function(result)
            vim.schedule(function()
                if result.code ~= 0 then
                    local message = vim.trim(result.stderr or '')
                    if message == '' then
                        message = 'git status exited with code ' .. result.code
                    end
                    vim.notify(message, vim.log.levels.WARN)
                    return
                end

                if not result.stdout or result.stdout == '' then
                    vim.notify('No git changes', vim.log.levels.INFO)
                    return
                end

                open_picker(build_items(result.stdout, root))
            end)
        end)
    end)
end

return git_st
