if vim.g.did_load_mini_plugin then
	return
end
vim.g.did_load_mini_plugin = true

local utils = require("getchoo.utils")
local files = require("mini.files")

files.setup()

utils.set_keymap("n", "<leader>t", function()
	if not files.close() then
		files.open()
	end
end)

local hipatterns = require("mini.hipatterns")

hipatterns.setup({
	highlighters = {
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

require("mini.indentscope").setup({
	options = { try_as_border = true },
})

-- Disable indentscope in some files
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"Trouble",
		"toggleterm",
	},

	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

require("mini.pairs").setup()
