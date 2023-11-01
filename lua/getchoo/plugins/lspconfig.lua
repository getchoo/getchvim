local sources = {
	["bashls"] = "bash-language-server",
	["clangd"] = "clangd",
	["eslint"] = "eslint",
	["nil_ls"] = "nil",
	["pyright"] = "pyright-langserver",
	["rust_analyzer"] = "rust-analyzer",
	["tsserver"] = "typescript-language-server",
}

local capabilities = vim.tbl_deep_extend(
	"force",
	require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
)

local all_config = {
	capabilities = capabilities,
}

local servers = {}
for server, binary in pairs(sources) do
	if vim.fn.executable(binary) == 1 then
		servers[server] = all_config
	end
end

servers["lua_ls"] = {
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}

for server, settings in pairs(servers) do
	require("lspconfig")[server].setup(settings)
end
