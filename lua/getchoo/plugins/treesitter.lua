return {
	"nvim-treesitter",
	event = vim.tbl_extend("force", require("getchoo.utils").lazy_file, { "DeferredUIEnter" }),
	after = function()
		vim.api.nvim_create_autocmd('FileType', {
			pattern = { '*' },
			callback = function() vim.treesitter.start() end,
		})

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
}
