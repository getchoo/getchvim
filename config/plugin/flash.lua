if vim.g.did_load_flash_plugin then
	return
end
vim.g.did_load_flash_plugin = true

require("flash").setup()
