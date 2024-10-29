if vim.g.did_load_flash_plugin then
	return
end
vim.g.did_load_flash_plugin = true

local utils = require("getchoo.utils")
local flash = require("flash")

flash.setup()

utils.set_keymap({ "n", "o", "x" }, "s", function()
	flash.jump()
end)
