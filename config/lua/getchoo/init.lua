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

local backupDir = vim.fn.stdpath("state") .. "/backup"
local b = io.open(backupDir, "r")
if b then
	b:close()
else
	os.execute("mkdir -p " .. backupDir)
end

opt.backupdir = backupDir

vim.g.mapleader = ","
vim.g.do_filetype_lua = 1
