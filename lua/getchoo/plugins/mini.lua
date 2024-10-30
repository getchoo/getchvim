return {
	{
		"mini.nvim",
		event = "DeferredUIEnter",
		keys = {
			{ "<leader>t", function()
				local files = require("mini.files")
				if not files.close() then
					files.open()
				end
			end
			}
		},
		before = function()
			-- Disable indentscope in some files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"Trouble",
					"toggleterm",
				},

				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		after = function()
			require("mini.files").setup()

			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})

			require("mini.icons").setup()
			require("mini.indentscope").setup({
				options = { try_as_border = true },
			})
			require("mini.surround").setup()
		end,
	}
}
