return {
    "goolord/alpha-nvim",
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require("alpha")
        local theme = require("alpha.themes.dashboard")

        theme.section.header.val = {

            [[╭━╮╭━╮╱╱╭━━━┳╮╱╭╮]],
            [[┃┃╰╯┃┃╱╱┃╭━╮┃┃╱┃┃]],
            [[┃╭╮╭╮┣━━┫┃╱╰┫╰━╯┃]],
            [[┃┃┃┃┃┃╭╮┃┃╱╭┫╭━╮┃]],
            [[┃┃┃┃┃┃╭╮┃╰━╯┃┃╱┃┃]],
            [[╰╯╰╯╰┻╯╰┻━━━┻╯╱╰╯]]
        }

        alpha.setup(theme.config)

    end,
}
