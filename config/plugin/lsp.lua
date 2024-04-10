if vim.g.did_load_lsp_plugin then
	return
end
vim.g.did_load_lsp_plugin = true

local lsp_servers = {
	astro = {
		binary = "astro-ls",
	},

	bashls = {
		binary = "bash-language-server",
	},

	biome = {},

	clangd = {},

	denols = {
		binary = "deno",
	},

	dprint = {},

	eslint = {
		binary = "vscode-eslint-language-server",
	},

	efm = {
		binary = "efm-langserver",
		extraOptions = require("getchoo.efmls"),
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

	nim_langserver = {
		binary = "nimlangserver",
	},

	pyright = {
		extraOptions = {
			settings = {
				-- ruff is used instead
				pyright = { disableOrganizeImports = true },
				python = { ignore = { "*" } },
			},
		},
	},

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

	statix = {},

	tsserver = {
		binary = "typescript-language-server",
	},

	typos_lsp = {
		binary = "typos-lsp",
	},

	typst_lsp = {
		binary = "typst-lsp",
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
