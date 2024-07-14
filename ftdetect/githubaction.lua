-- this allows `actionlint` to only yaml files that are actions
vim.filetype.add({
	pattern = {
		[".*/.github/workflows/.*%.yml"] = "yaml.githubaction",
		[".*/.github/workflows/.*%.yaml"] = "yaml.githubaction",
	},
})
