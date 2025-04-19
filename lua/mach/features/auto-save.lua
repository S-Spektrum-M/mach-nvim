-- Auto-save on text change (with debounce and notify)
local autosave_timer = vim.loop.new_timer()

local function save_buf(args)
    local bufnr = args.buf
    if vim.api.nvim_buf_is_valid(bufnr)
        and vim.api.nvim_buf_get_option(bufnr, "modified")
        and vim.api.nvim_buf_get_option(bufnr, "buftype") == ""
    then
        if vim.mach_opts.mach_builtins.autosave.enabled then
            vim.api.nvim_command("silent! write")
            if vim.mach_opts.mach_builtins.autosave.notify then
                vim.notify(
                    "Auto-saved " .. vim.api.nvim_buf_get_name(bufnr),
                    vim.log.levels.INFO,
                    { title = "AutoSave" })
            end
        end
    end
end

vim.api.nvim_create_autocmd("TextChanged", {
    group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
    callback = function(args)
        autosave_timer:stop()
        autosave_timer:start(vim.mach_opts.mach_builtins.autosave.autosave_time, 0,
            vim.schedule_wrap(function() save_buf(args) end))
    end
})
