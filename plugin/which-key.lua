if vim.g.did_load_which_key_plugin then
	return
end
vim.g.did_load_which_key_plugin = true

require("which-key").setup({
	plugins = {
		spelling = { enable = true },
	},
})
