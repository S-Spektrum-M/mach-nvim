local ac = vim.api.nvim_create_autocmd
ac("BufWrite", { command = [[%s/\s\+$//e]] }) -- Remove trailing whitespace on write

ac("FileType", {
    pattern = { "Avante", "AvanteInput", "AvanteSelectedFiles" },
    callback = function()
        vim.schedule(function()
            vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true })
        end)
    end
})
