if vim.g.did_load_just_plugin then
	return
end

vim.g.did_load_just_plugin = true
vim.filetype.add({
	filename = {
		["justfile"] = "just",
	},
})
