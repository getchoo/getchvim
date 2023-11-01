require("getchoo.plugins.bufferline")
require("getchoo.plugins.catppuccin")
require("getchoo.plugins.lualine")
require("getchoo.plugins.neo-tree")

---- gitsigns
require("gitsigns").setup()

---- indent-blankline.nvim
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

	scope = { enabled = false },
})

---- mini.nvim
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

---- which-key
require("which-key").setup({
	plugins = { spelling = true },
})
