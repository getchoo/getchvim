require("lint").linters_by_ft = {
	githubaction = { "actionlint" },
	lua = { "selene" },
	nix = { "statix" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- Run linters declared in linters_by_ft
		require("lint").try_lint()

		-- Run these linters regardless of filetype
		require("lint").try_lint("alex")
	end,
})
