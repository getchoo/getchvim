if vim.g.did_load_glow_plugin then
	return
end
vim.g.did_load_glow_plugin = true

require("glow").setup()
