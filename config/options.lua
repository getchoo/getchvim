local opt = vim.opt

opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = true
opt.syntax = "on"
opt.termguicolors = true

local backupDir = vim.fn.stdpath("state") .. "/backup"
local b = io.open(backupDir, "r")
if b then
  b:close()
else 
  os.execute("mkdir -p " .. backupDir)
end

opt.backupdir = backupDir
