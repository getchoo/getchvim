local commonArgs = {
	automatic_installation = true,
}

require("mason").setup()
require("mason-null-ls").setup(commonArgs)
require("mason-lspconfig").setup(commonArgs)
