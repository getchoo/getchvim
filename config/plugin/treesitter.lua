if vim.g.did_load_treesitter_plugin then
	return
end
vim.g.did_load_treesitter_plugin = true

require("nvim-treesitter.configs").setup({
	auto_install = false,

	highlight = { enable = true },
	indent = { enable = true },

	-- nvim-ts-autotag
	autotag = { enable = true },
})

vim.g.skip_ts_context_commentstring_module = true
