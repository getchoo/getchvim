return {
	{
		"lualine.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
				extensions = { "trouble" },
			})
		end
	}
}
