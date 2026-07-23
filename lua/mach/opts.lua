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
opt.colorcolumn = "120"
opt.termguicolors = true
opt.conceallevel = 2

wopt.spell = false
bopt.spelllang = "en_us"

opt.signcolumn = "auto"
opt.termguicolors = true

opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

vim.g.mapleader = " "
