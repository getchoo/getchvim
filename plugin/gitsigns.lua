if vim.g.did_load_gitsigns_plugin then
	return
end
vim.g.did_load_gitsigns_plugin = true

require("gitsigns").setup()
