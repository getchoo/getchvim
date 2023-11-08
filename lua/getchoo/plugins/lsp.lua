require("getchoo.plugins.cmp")
require("getchoo.plugins.lspconfig")
require("getchoo.plugins.null-ls")

require("gitsigns").setup()

require("fidget").setup()

require("mini.comment").setup({
	options = {
		custom_commentstring = function()
			return require("ts_context_commentstring.internal").calculate_commentstring()
				or vim.bo.context_commentstring
		end,
	},
})

require("nvim-treesitter.configs").setup({
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})

---- trouble
require("trouble").setup()