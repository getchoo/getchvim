local compile_path = vim.fn.stdpath("cache") .. "/catppuccin-nvim"

return {
	{
		"catppuccin-nvim",
		colorscheme = "catppuccin",
		before = function()
			vim.fn.mkdir(compile_path, "p")
			vim.opt.runtimepath:append(compile_path)
		end,
		after = function()
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
					treesitter = true,
					telescope = true,
					which_key = true,
				},

				no_italic = true,
			})
		end
	}
}
