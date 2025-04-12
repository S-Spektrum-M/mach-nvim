vim.opt.signcolumn    = "auto"
vim.opt.termguicolors = true

local FG              = vim.api.nvim_get_hl(0, { name = "Normal", }).fg
local BG_darker       = vim.api.nvim_get_hl(0, { name = "NormalFloat", }).bg
local BG              = vim.api.nvim_get_hl(0, { name = "Normal", }).bg

-- structure:
-- HighlightTable
-- L Suite1             <- Auxiliary structure to help with organization
--  L Group1            <- Highlight group
--   L fg =             <- Foreground Highlight
--   L bg =             <- Background Highlight
--  L ...
--  L GroupN
-- L ...
-- L SuiteN
local HighlightTable  = {
    General = { NormalFloat = { bg = BG, fg = FG, } },
    StatusColumn = {
        StatusColumnBorder = { fg = "#363a4e", bg = "#22252A" },
        StatusColumnBuffer = { fg = "NONE", bg = "NONE" },
        StatusColumnBufferCursorLine = { fg = "NONE", bg = "#383746" }
    },
    Snacks = {
        SnacksPicker = {
            bg = BG_darker,
            fg = FG,
        },
        SnacksPickerBorder = {
            bg = BG_darker,
            fg = BG_darker,
        },
        SnacksPickerInput = {
            bg = prompt,
        },
        SnacksPickerInputTitle = {
            bg = prompt,
        },
        SnacksPickerBoxTitle = {
            bg = prompt,
            fg = prompt
        },
        SnacksPickerBoxBorder = {
            bg = prompt,
            fg = prompt
        },
        SnacksPickerPreviewTitle = {
            bg = BG_darker,
            fg = BG_darker,
        },
        SnacksPickerInputBorder = {
            bg = prompt,
        },
    }
}

for _, v in pairs(HighlightTable) do
    for hl, col in pairs(v) do
        vim.api.nvim_set_hl(0, hl, col)
    end
end
