return {
	{
		"trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>p", "<cmd>Trouble diagnostics toggle<cr>" }
		},
		after = function()
			require("trouble").setup()
		end
	}
}
