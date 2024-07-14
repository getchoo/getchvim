if vim.g.did_load_bufferline_plugin then
	return
end
vim.g.did_load_bufferline_plugin = true

require("bufferline").setup({
	options = {
		always_show_bufferline = false,

		diagnostics = "nvim_lsp",

		mode = "buffers",
		numbers = "ordinal",
		separator_style = "slant",
	},
})
