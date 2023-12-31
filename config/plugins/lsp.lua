local lsp_servers = {
	bashls = {
		binary = "bash-language-server",
	},

	clangd = {},

	eslint = {},

	efm = {
		binary = "true",
		extraOptions = require("getchoo.plugins.efmls"),
	},

	lua_ls = {
		binary = "lua-language-server",
		extraOptions = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = "vim" },
					workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				},
			},
		},
	},

	nil_ls = {
		binary = "nil",
		extraOptions = {
			settings = {
				["nil"] = {
					formatting = { command = { "alejandra" } },
				},
			},
		},
	},

	pyright = {},
	ruff_lsp = {
		binary = "ruff-lsp",
		extraOptions = {
			on_attach = function(client, _)
				require("lsp-format").on_attach(client)
				-- pyright should handle this
				client.server_capabilities.hoverProvider = false
			end,
		},
	},

	rust_analyzer = {
		binary = "rust-analyzer",
		extraOptions = {
			settings = {
				checkOnSave = { command = "clippy" },
			},
		},
	},

	denols = {
		binary = "deno",
	},

	tsserver = {
		binary = "typescript-language-server",
	},
}

local caps = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities(),
	-- for nil_ls
	{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
)

local setup = {
	on_attach = function(client, _)
		require("lsp-format").on_attach(client)
	end,

	capabilities = caps,
}

for server, config in pairs(lsp_servers) do
	local binary = config.binary or server

	local options = (config.extraOptions == nil) and setup or vim.tbl_extend("keep", config.extraOptions, setup)

	if vim.fn.executable(binary) == 1 then
		require("lspconfig")[server].setup(options)
	end
end
