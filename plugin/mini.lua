if vim.g.did_load_mini_plugin then
	return
end
vim.g.did_load_mini_plugin = true

require("mini.files").setup()
require("mini.indentscope").setup({
	options = { try_as_border = true },
})
require("mini.pairs").setup()

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
