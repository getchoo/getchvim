return {
	{
		"flash.nvim",
		event = "DeferredUIEnter",
		keys = {
			{
				"s", function() require("flash").jump() end, mode = { "n", "o", "x" }
			}
		},
	}
}
