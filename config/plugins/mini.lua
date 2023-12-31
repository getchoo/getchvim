require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring()
				or vim.bo.context_commentstring
		end,
	},
})

require("mini.pairs").setup()
require("mini.indentscope").setup({
	options = { try_as_border = true },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"neo-tree",
		"Trouble",
		"lazy",
		"mason",
		"notify",
		"toggleterm",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
