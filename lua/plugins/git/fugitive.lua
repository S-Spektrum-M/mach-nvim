local function git_st()
    local git_status = vim.fn.system('git status --short')
    if git_status == '' or git_status == nil then
        vim.notify('No git changes', vim.log.levels.INFO)
        return
    end

    local items = {}
    local item_index = 1

    -- Helper function to add directory contents recursively
    local function add_directory_contents(dir_path, base_status)
        local handle = vim.loop.fs_scandir(dir_path)
        if not handle then
            return
        end

        while true do
            local name, type = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end

            local full_path = dir_path .. '/' .. name

            if type == 'file' then
                table.insert(items, {
                    idx = item_index,
                    score = item_index,
                    text = full_path .. ' (from directory)',
                    status = base_status,
                    file = full_path,
                })
                item_index = item_index + 1
            elseif type == 'directory' and name ~= '.git' then
                -- Recursively add subdirectory contents
                add_directory_contents(full_path, base_status)
            end
        end
    end

    for line in vim.gsplit(git_status, '\n') do
        if line ~= '' then
            local status = line:sub(1, 2)
            local file_part = line:sub(4)
            local file_to_open = file_part

            if status:match('R') then
                local parts = vim.split(file_part, ' -> ')
                file_to_open = parts[2]
            end

            -- Check if the path is a directory
            local is_directory = vim.fn.isdirectory(file_to_open) == 1

            if is_directory then
                -- Add the directory entry itself
                table.insert(items, {
                    idx = item_index,
                    score = item_index,
                    text = file_part .. ' (directory)',
                    status = status,
                    file = file_to_open,
                    is_directory = true,
                })
                item_index = item_index + 1

                -- Add all files within the directory
                add_directory_contents(file_to_open, status)
            else
                -- Regular file entry
                table.insert(items, {
                    idx = item_index,
                    score = item_index,
                    text = file_part,
                    status = status,
                    file = file_to_open,
                })
                item_index = item_index + 1
            end
        end
    end

    require('snacks').picker({
        items = items,
        format = function(item)
            local ret = {}
            local status_hl_map = {
                [' M'] = { text = 'M', hl = 'SnacksPickerModified' },
                ['M '] = { text = 'M', hl = 'SnacksPickerModified' },
                ['MM'] = { text = 'M', hl = 'SnacksPickerModified' },
                ['A '] = { text = 'A', hl = 'SnacksPickerAdded' },
                ['AM'] = { text = 'A', hl = 'SnacksPickerAdded' },
                ['AD'] = { text = 'A', hl = 'SnacksPickerAdded' },
                ['D '] = { text = 'D', hl = 'SnacksPickerDeleted' },
                [' D'] = { text = 'D', hl = 'SnacksPickerDeleted' },
                ['R '] = { text = 'R', hl = 'SnacksPickerRenamed' },
                ['??'] = { text = '?', hl = 'SnacksPickerUntracked' },
            }
            local status_display = status_hl_map[item.status] or { text = item.status, hl = 'SnacksPickerDefault' }
            ret[#ret + 1] = { '[' .. status_display.text .. ']', status_display.hl }

            -- Add visual indicator for directories
            local text_hl = item.is_directory and 'SnacksPickerDirectory' or 'SnacksPickerPath'
            ret[#ret + 1] = { ' ' .. item.text, text_hl }
            return ret
        end,
        on_select = function(item)
            if item and item.file then
                if item.status:match('D') then
                    vim.notify('Cannot open a deleted file: ' .. item.file, vim.log.levels.WARN)
                elseif item.is_directory then
                    vim.notify('Cannot open directory directly: ' .. item.file, vim.log.levels.WARN)
                else
                    vim.cmd('edit ' .. item.file)
                end
            end
        end,
    })
end

return {
    'tpope/vim-fugitive',
    keys = {
        { '<leader>gac', ':Git commit % --amend',    desc = 'commit current file' },
        { '<leader>gc', ':Git commit %',    desc = 'commit current file' },
        { '<leader>gs', git_st,             desc = 'Git status picker' },
        { '<leader>gp', ':Git push origin', desc = 'push commits to origin' },
        { '<leader>gP', ':Git pull origin', desc = 'push from origin' },
        {
            '<leader>gL',
            '<cmd>Git log --graph --date=relative --pretty=tformat:\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset\'<CR>',
            desc = 'display log'
        },
        {
            '<leader>gS',
            '<cmd>Git status<CR>',
            desc = 'display git status'
        },
    }
}

