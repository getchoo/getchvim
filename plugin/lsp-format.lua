if vim.g.did_load_lsp_format_plugin then
	return
end
vim.g.did_load_lsp_format_plugin = true

require("lsp-format").setup()
