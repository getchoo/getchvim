return {
	{
		"indent-blankline.nvim",
		event = require("getchoo.utils").lazy_file,
		after = function()
			require("ibl").setup({
				exclude = {
					filetypes = {
						"help",
						"Trouble",
						"toggleterm",
					},
				},

				indent = {
					char = "│",
					tab_char = "│",
				},

				scope = {
					-- Let mini.nvim handle this
					enabled = false,
				},
			})
		end
	}
}
