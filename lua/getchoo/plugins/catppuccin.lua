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
					gitsigns = true,
					native_lsp = {
						enabled = true,
					},
					treesitter = true,
					telescope = true,
				},

				no_italic = true,
			})
		end,
	},
}
