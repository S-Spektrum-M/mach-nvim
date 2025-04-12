--[[ for _, plugin in ipairs(
    {
  "gzip", "zipPlugin", "tarPlugin", "netrwPlugin", "matchit",
  "matchparen", "tutor", "spellfile_plugin", "tohtml",
  "man", "rplugin", "editorconfig",
}
) do
  vim.g["loaded_" .. plugin] = 1
end ]]

vim.cmd [[
    filetype plugin indent on
    syntax enable
]]

local opt = vim.opt
local wopt = vim.wo
local bopt = vim.bo

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.autowrite = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.encoding = "utf-8"
opt.updatetime = 10
opt.backup = false
opt.swapfile = false
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.cursorline = true
opt.laststatus = 3
opt.cmdheight = 0
opt.colorcolumn = "80"
opt.termguicolors = true
opt.conceallevel = 2

wopt.spell = false
bopt.spelllang = "en_us"

opt.laststatus = 3

vim.g.mapleader = " "
