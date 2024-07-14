if vim.g.did_load_ibl_plugin then
	return
end
vim.g.did_load_ibl_plugin = true

require("ibl").setup({
	exclude = {
		filetypes = {
			"help",
			"neo-tree",
			"Trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
		},
	},

	indent = {
		char = "│",
		tab_char = "│",
	},

	scope = {
		enabled = false,
	},
})
