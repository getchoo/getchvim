local lsp_servers = {
	astro = {},

	bashls = {},

	cssls = {},

	clangd = {},

	denols = {},

	dprint = {},

	eslint = {},

	harper_ls = {
		filetypes = { "markdown" }
	},

	html = {},

	jsonls = {},

	-- TODO: I WANT STYLUA BACK!!
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = "vim" },
				workspace = { checkThirdPaty = false, library = { vim.env.VIMRUNTIME } },
			},
		},
	},

	nim_langserver = {},

	nixd = {
		settings = {
			nixd = {
				formatting = { command = { "nixfmt" } },
				nixpkgs = {
					expr = "import <nixpkgs> { config = { allowUnfree = true; }; overlays = [ ]; }",
				},
				options = {
					nixos = {
						expr = '((import <nixpkgs> { config = { allowUnfree = true; }; overlays = [ ]; }).nixos { }).options',
					},
				},
			},
		},
	},

	pyright = {
		settings = {
			-- ruff is used instead
			pyright = { disableOrganizeImports = true },
			python = { ignore = { "*" } },
		},
	},

	ruff = {
		on_attach = function(client, _)
			require("lsp-format").on_attach(client)
			-- pyright should handle this
			client.server_capabilities.hoverProvider = false
		end,
	},

	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				check = { command = "clippy" },
			},
		},
	},

	terraformls = {},

	ts_ls = {},

	typos_lsp = {},

	typst_lsp = {},
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


return {
	{
		"lspformat.nvim",
		command = "FormatToggle",
		keys = { { "<leader>z", "<cmd>FormatToggle<cr>" } },
		after = function()
			require("lsp-format").setup()
		end
	},
	{
		"nvim-lspconfig",
		event = require("getchoo.utils").lazy_file,
		keys = {
			{ "<leader>e",  vim.diagnostic.open_float },
			{ "[d",         vim.diagnostic.goto_prev },
			{ "]d",         vim.diagnostic.goto_next },
			{ "<leader>u",  vim.diagnostic.setloclist },
			{ "<leader>ca", vim.lsp.buf.code_action }
		},
		after = function()
			for server, config in pairs(lsp_servers) do
				local binary = vim.lsp.config[server].cmd[1] or nil
				local options = (next(config) == nil) and setup or vim.tbl_extend("keep", config, setup)

				vim.lsp.config(server, options)
				if vim.fn.executable(binary) == 1 then
					vim.lsp.enable(server)
				end
			end
		end
	}
}
