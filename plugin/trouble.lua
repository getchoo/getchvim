if vim.g.did_load_trouble_plugin then
	return
end
vim.g.did_load_trouble_plugin = true

local utils = require("getchoo.utils")

require("trouble").setup()
utils.set_keymap("n", "<leader>p", function()
	vim.cmd("Trouble diagnostics toggle")
end)
