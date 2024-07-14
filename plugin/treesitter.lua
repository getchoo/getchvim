if vim.g.did_load_treesitter_plugin then
	return
end
vim.g.did_load_treesitter_plugin = true

require("nvim-treesitter.configs").setup({
	auto_install = false,

	highlight = { enable = true },
	indent = { enable = true },
})
