local cmd = vim.cmd
local opt = vim.opt

-- text options
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.smartindent = true
opt.wrap = true
opt.relativenumber = true

-- appearance
opt.syntax = "on"
cmd("filetype plugin indent on")
opt.termguicolors = true

require("getchoo.keybinds")

if vim.g.use_plugins then
	require("getchoo.plugins")
end
