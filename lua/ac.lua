local ac = vim.api.nvim_create_autocmd
ac("BufWrite",{ command = [[%s/\s\+$//e]]}) -- Remove trailing whitespace on write
