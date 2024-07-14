if vim.g.did_load_mini_plugin then
	return
end
vim.g.did_load_mini_plugin = true

require("mini.comment").setup()
require("mini.files").setup()
require("mini.pairs").setup()
require("mini.indentscope").setup({
	options = { try_as_border = true },
})

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
