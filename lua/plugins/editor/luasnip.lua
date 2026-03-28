return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
        "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
    config = function()
        local ls = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = false,
        })

        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
            end
        end, { silent = true, desc = "luasnip expand or jump" })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true, desc = "luasnip jump back" })
    end,
}
