if vim.g.did_load_trouble_plugin then
	return
end
vim.g.did_load_trouble_plugin = true

require("trouble").setup()
