local g = vim.g
local opt = vim.opt

g.mapleader = ","

-- indent shenanigans
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = false
---- https://www.reddit.com/r/neovim/comments/14n6iiy/if_you_have_treesitter_make_sure_to_disable
---- TLDR: this breaks things with treesitter indent
opt.smartindent = false

-- line stuff
opt.number = true
opt.wrap = true

-- ui
opt.mouse = "a"
opt.showmode = false -- status line does this
