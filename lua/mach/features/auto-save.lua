-- Auto-save on text change (with debounce and notify)
local autosave_timer = vim.loop.new_timer()

vim.api.nvim_create_autocmd("TextChanged", {
  group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
  callback = function(args)
    autosave_timer:stop()
    autosave_timer:start(300, 0, vim.schedule_wrap(function()
      local bufnr = args.buf
      if vim.api.nvim_buf_is_valid(bufnr)
          and vim.api.nvim_buf_get_option(bufnr, "modified")
          and vim.api.nvim_buf_get_option(bufnr, "buftype") == ""
      then
        vim.api.nvim_command("silent! write")
        vim.notify("Auto-saved " .. vim.api.nvim_buf_get_name(bufnr), vim.log.levels.INFO, { title = "AutoSave" })
      end
    end))
  end
})
