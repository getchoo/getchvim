local opt = vim.opt

opt.shiftwidth = 2
opt.tabstop = 2
-- https://www.reddit.com/r/neovim/comments/14n6iiy/if_you_have_treesitter_make_sure_to_disable
-- TLDR: this breaks things with treesitter indent
opt.smartindent = false
opt.number = true
opt.wrap = true
opt.syntax = "on"
opt.termguicolors = true
opt.mouse = "a"
