if vim.g.did_load_fidget_plugin then
	return
end
vim.g.did_load_fidget_plugin = true

require("fidget").setup()
