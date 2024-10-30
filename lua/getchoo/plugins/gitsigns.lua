return {
	{
		"gitsigns.nvim",
		event = require("getchoo.utils").lazy_file,
		after = function()
			require("gitsigns").setup()
		end,
	}
}
