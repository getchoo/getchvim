if vim.g.did_load_crates_plugin then
	return
end
vim.g.did_load_crates_plugin = true

require("crates").setup()
