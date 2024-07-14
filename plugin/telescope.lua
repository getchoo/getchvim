if vim.g.did_load_telescope_plugin then
	return
end
vim.g.did_load_telescope_plugin = true

require("telescope").setup()
