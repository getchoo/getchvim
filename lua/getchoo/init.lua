local g = vim.g
local opt = vim.opt

g.mapleader = ","

-- indent options
opt.shiftwidth = 2
opt.tabstop = 2

-- line stuff
opt.number = true
opt.wrap = true

-- ui
opt.mouse = "a"
opt.showmode = false -- status line does this

require("lz.n").load("getchoo/plugins")

vim.cmd.colorscheme("catppuccin")
