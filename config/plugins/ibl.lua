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
