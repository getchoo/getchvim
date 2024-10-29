return {
	{
		"telescope.nvim",
		keys = {
			{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>" }
		},
		after = function()
			require("telescope").setup()
		end
	}
}
