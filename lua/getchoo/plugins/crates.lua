return {
	{
		"crates.nvim",
		event = "BufReadPost Cargo.toml",
		after = function()
			require("crates").setup()
		end
	}
}
