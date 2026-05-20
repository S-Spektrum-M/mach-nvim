local lib = {}

function lib.new()
    return setmetatable({}, { __index = lib })
end

function lib:get_trigger_characters()
    return { '@' }
end

function lib:get_completions(context, callback)
    local is_text = vim.bo.filetype == 'text'
    local filepath = vim.api.nvim_buf_get_name(0)
    local is_in_tmp = filepath:match("^/tmp/") ~= nil

    if not (is_text and is_in_tmp) then
        callback()
        return
    end

    local line = context.line
    local col = context.cursor[2]
    local before_cursor = line:sub(1, col)

    local match = before_cursor:match("@([^%s]*)$")
    if not match then
        callback()
        return
    end

    local cwd = vim.fn.getcwd()
    local files = vim.fn.glob(cwd .. '/*', false, true)
    local items = {}

    for _, file in ipairs(files) do
        local tail = vim.fn.fnamemodify(file, ':t')
        local is_dir = vim.fn.isdirectory(file) == 1
        local label = is_dir and (tail .. '/') or tail

        table.insert(items, {
            label = label,
            insertText = tail,
            kind = is_dir and vim.lsp.protocol.CompletionItemKind.Folder or vim.lsp.protocol.CompletionItemKind.File,
        })
    end

    callback({
        is_incomplete_forward = false,
        is_incomplete_backward = false,
        items = items,
    })
end

return lib
