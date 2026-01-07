-- this allows `actionlint` to only load yaml files that are actions
if vim.g.did_load_githubaction_plugin then
	return
end

vim.g.did_load_githubaction_plugin = true
vim.filetype.add({
	pattern = {
		[".*/.github/workflows/.*%.yml"] = "yaml.githubaction",
		[".*/.github/workflows/.*%.yaml"] = "yaml.githubaction",
	},
})
