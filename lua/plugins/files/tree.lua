return {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeFocus', 'NvimTreeToggle' },
    dependencies = {
        'b0o/nvim-tree-preview.lua',
    },
    config = function()
        local preview = require 'nvim-tree-preview'
        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end
            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
            -- custom mappings
            vim.keymap.set('n', 'p', preview.watch, opts 'Preview (Watch)')
            vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
        end
        require("nvim-tree").setup({
            on_attach = my_on_attach,
        })
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        preview.setup({
            keymaps = {
                ['<Esc>'] = { action = 'close', unwatch = true },
                ['<Tab>'] = { action = 'toggle_focus' },
                ['<CR>'] = { open = 'edit' },
                ['<C-t>'] = { open = 'tab' },
                ['<C-v>'] = { open = 'vertical' },
                ['<C-x>'] = { open = 'horizontal' },
            },
            min_width = 10,
            min_height = 5,
            max_width = 85,
            max_height = 25,
            wrap = false,       -- Whether to wrap lines in the preview window
            border = 'rounded', -- Border style for the preview window
        })
    end,
    keys = {
        { '<C-t>', '<cmd>NvimTreeToggle<cr>', desc = "Focus nvim-tree" }
    }
}
