return {
	"nvim-treesitter",
	event = vim.tbl_extend("force", require("getchoo.utils").lazy_file, { "DeferredUIEnter" }),
	after = function()
		require("nvim-treesitter.configs").setup({
			auto_install = false,

			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
