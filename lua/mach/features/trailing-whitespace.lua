if vim.mach_opts.mach_builtins.whitespace.enabled then
    vim.api.nvim_create_autocmd("BufWrite", { command = [[%s/\s\+$//e]] }) -- Remove trailing whitespace on write
end
