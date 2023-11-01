local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting(bufnr)
				end,
			})
		end
	end,

	sources = {
		diagnostics.actionlint,
		diagnostics.alex,
		diagnostics.codespell,
		diagnostics.deadnix,
		diagnostics.pylint,
		diagnostics.shellcheck,
		diagnostics.statix,
		formatting.alejandra,
		formatting.beautysh,
		formatting.codespell,
		formatting.just,
		formatting.nimpretty,
		formatting.prettier,
		formatting.rustfmt,
		formatting.shellharden,
		formatting.stylua,
		formatting.yapf,
	},
})
