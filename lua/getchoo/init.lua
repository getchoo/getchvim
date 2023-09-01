local cmd = vim.cmd
local opt = vim.opt

-- text options
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.smartindent = true
opt.wrap = false

-- appearance
opt.syntax = "on"
cmd("filetype plugin indent on")
opt.termguicolors = true

require("getchoo.keybinds")
require("getchoo.filetypes")

if vim.g.no_plugins then
	require("getchoo.plugins")
end
