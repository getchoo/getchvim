if vim.g.did_load_ibl_plugin then
	return
end
vim.g.did_load_ibl_plugin = true

require("ibl").setup({
	exclude = {
		filetypes = {
			"help",
			"Trouble",
			"toggleterm",
		},
	},

	indent = {
		char = "│",
		tab_char = "│",
	},

	scope = {
		-- Let mini.nvim handle this
		enabled = false,
	},
})
