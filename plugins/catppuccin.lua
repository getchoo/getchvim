return function()
	require("catppuccin").setup({
		compile_path = compile_path,
		flavour = "mocha", -- mocha, macchiato, frappe, latte
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
			notify = true,
			treesitter_context = true,
			treesitter = true,
			telescope = true,
			which_key = true,
		},

		no_italic = true,
	})

	vim.cmd.colorscheme("catppuccin")
end
