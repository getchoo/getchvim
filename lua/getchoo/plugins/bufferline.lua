require("bufferline").setup({
	options = {
		always_show_bufferline = false,
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
		diagnostics = "nvim_lsp",
		mode = "buffers",
		numbers = "ordinal",
		separator_style = "slant",
		offsets = {
			{
				filetype = "neo-tree",
				text = "neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
