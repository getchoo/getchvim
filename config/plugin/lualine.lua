if vim.g.did_load_lualine_plugin then
	return
end
vim.g.did_load_lualine_plugin = true

require("lualine").setup({
	options = {
		theme = "catppuccin",
	},
	extensions = { "neo-tree", "trouble" },
})
