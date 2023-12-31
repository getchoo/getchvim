local alex = require("efmls-configs.linters.alex")
local actionlint = require("efmls-configs.linters.actionlint")
local beautysh = require("efmls-configs.formatters.beautysh")
local codespell = require("efmls-configs.linters.codespell")
local fish_indent = require("efmls-configs.formatters.fish_indent")
local prettier = require("efmls-configs.formatters.prettier")
local prettier_eslint = require("efmls-configs.formatters.prettier_eslint")
local shellcheck = require("efmls-configs.linters.shellcheck")
local statix = require("efmls-configs.linters.statix")
local stylua = require("efmls-configs.formatters.stylua")

local languages = {
	all = { alex, codespell },

	bash = {
		beautysh,
		shellcheck,
	},

	css = { prettier },

	fish = { fish_indent },

	html = { prettier },

	javascript = { prettier_eslint },

	json = { prettier },

	lua = { stylua },

	nix = { statix },

	sass = { prettier },

	scss = { prettier },

	sh = { beautysh, shellcheck },

	typescript = { prettier_eslint },

	yaml = { prettier, actionlint },

	zsh = { beautysh },
}

return {
	filetypes = vim.tbl_keys(languages),

	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},

	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}
