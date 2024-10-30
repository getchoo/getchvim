return {
	"nvim-lint",
	event = require("getchoo.utils").lazy_file,
	before = function()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				-- Run linters declared in linters_by_ft
				require("lint").try_lint()

				-- Run these linters regardless of filetype
				require("lint").try_lint("alex")
			end,
		})
	end,
	after = function()
		require("lint").linters_by_ft = {
			githubaction = { "actionlint" },
			lua = { "selene" },
			nix = { "statix" },
		}
	end
}
