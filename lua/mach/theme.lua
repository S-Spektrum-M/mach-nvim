vim.opt.signcolumn    = "auto"
vim.opt.termguicolors = true

local FG              = '#56B6C2'
local BG_darker       = '#000000'
local BG              = '#111111'

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
    Notify = {
        NotifyERRORBorder = { fg = "#8A1F1F" },
        NotifyWARNBorder  = { fg = "#79491D" },
        NotifyINFOBorder  = { fg = "#4F6752" },
        NotifyDEBUGBorder = { fg = "#8B8B8B" },
        NotifyTRACEBorder = { fg = "#4F3552" },
        NotifyERRORIcon   = { fg = "#F70067" },
        NotifyWARNIcon    = { fg = "#F79000" },
        NotifyINFOIcon    = { fg = "#A9FF68" },
        NotifyDEBUGIcon   = { fg = "#8B8B8B" },
        NotifyTRACEIcon   = { fg = "#D484FF" },
        NotifyERRORTitle  = { fg = "#F70067" },
        NotifyWARNTitle   = { fg = "#F79000" },
        NotifyINFOTitle   = { fg = "#A9FF68" },
        NotifyDEBUGTitle  = { fg = "#8B8B8B" },
        NotifyTRACETitle  = { fg = "#D484FF" },
        NotifyBackground  = { bg = "#000000" },
    },
    StatusColumn = {
        StatusColumnBorder = { fg = "#363a4e", bg = "#22252A" },
        StatusColumnBuffer = { fg = "NONE", bg = "NONE" },
        StatusColumnBufferCursorLine = { fg = "NONE", bg = "#383746" }
    }
}
for _, v in pairs(HighlightTable) do
    for hl, col in pairs(v) do
        vim.api.nvim_set_hl(0, hl, col)
    end
end

vim.opt.background = "dark"
