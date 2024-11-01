vim.g.mapleader = " "

local opt = vim.opt

opt.termguicolors = true
opt.number = false

opt.tabstop = 4
opt.expandtab = true
opt.shiftwidth = 4

vim.cmd([[colorscheme catppuccin]])
vim.cmd([[highlight Normal guibg=none]])
