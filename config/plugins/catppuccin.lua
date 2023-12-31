local compile_path = vim.fn.stdpath("cache") .. "/catppuccin-nvim"
vim.fn.mkdir(compile_path, "p")
vim.opt.runtimepath:append(compile_path)

require("catppuccin").setup({
	compile_path = compile_path,
	flavour = "mocha",
	integrations = {
		cmp = true,
		flash = true,
		gitsigns = true,
		indent_blankline = {
			enabled = true,
		},
		lsp_trouble = true,
		native_lsp = {
			enabled = true,
		},
		neotree = true,
		treesitter_context = true,
		treesitter = true,
		telescope = true,
		which_key = true,
	},

	no_italic = true,
})

vim.cmd.colorscheme("catppuccin")
