return {
	{
		"flash.nvim",
		event = "DeferredUIEnter",
		keys = {
			{
				"f", function() require("flash").jump() end, mode = { "n", "o", "x" }
			}
		},
	}
}
