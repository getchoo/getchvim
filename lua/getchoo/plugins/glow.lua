return {
	{
		"glow.nvim",
		ft = "markdown",
		after = function()
			require("glow").setup()
		end
	}
}
