local g = vim.g
local opt = vim.opt

g.mapleader = ","

opt.autoindent = true
opt.mouse = "a"
opt.number = true
opt.smartindent = true
opt.wrap = true

-- don't use remote plugins
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0

require("lz.n").load("getchoo/plugins")

vim.cmd.colorscheme("catppuccin")
