local alex = require("efmls-configs.linters.alex")
alex.rootMarkers = nil
local actionlint = require("efmls-configs.linters.actionlint")
local beautysh = require("efmls-configs.formatters.beautysh")
local fish_indent = require("efmls-configs.formatters.fish_indent")
local prettier = require("efmls-configs.formatters.prettier")
local prettier_eslint = require("efmls-configs.formatters.prettier_eslint")
local selene = require("efmls-configs.linters.selene")
local statix = require("efmls-configs.linters.statix")
local stylua = require("efmls-configs.formatters.stylua")

local languages = {
	all = { alex },

	bash = {
		beautysh,
	},

	css = { prettier },

	fish = { fish_indent },

	html = { prettier },

	javascript = { prettier_eslint },

	json = { prettier },

	lua = { selene, stylua },

	nix = { statix },

	sass = { prettier },

	scss = { prettier },

	sh = { beautysh },

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
