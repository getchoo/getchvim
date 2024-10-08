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

	cssls = {
		binary = "vscode-css-language-server",
	},

	clangd = {},

	denols = {
		binary = "deno",
	},

	dprint = {},

	eslint = {
		binary = "vscode-eslint-language-server",
	},

	html = {
		binary = "vscode-html-language-server",
	},

	jsonls = {
		binary = "vscode-json-language-server"
	},

	-- TODO: I WANT STYLUA BACK!!
	lua_ls = {
		binary = "lua-language-server",
		extraOptions = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = "vim" },
					workspace = { checkThirdPaty = false, library = { vim.env.VIMRUNTIME } },
				},
			},
		},
	},

	nil_ls = {
		binary = "nil",
		extraOptions = {
			settings = {
				["nil"] = {
					formatting = { command = { "nixfmt" } },
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
				["rust-analyzer"] = {
					check = { command = "clippy" },
				},
			},
		},
	},

	ts_ls = {
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
