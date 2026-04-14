local lsp_servers = {
	astro = {},

	bashls = {},

	cssls = {},

	clangd = {},

	denols = {},

	dprint = {},

	eslint = {},

	harper_ls = {
		filetypes = { "markdown" },
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

	nil_ls = {
		settings = {
			["nil"] = {
				formatting = { command = { "nixfmt" } },
				nix = {
					autoArchive = false,
					autoEvalInputs = true,
				},
			},
		},
	},

	nim_langserver = {},

	pyright = {
		settings = {
			-- ruff is used instead
			pyright = { disableOrganizeImports = true },
			python = { ignore = { "*" } },
		},
	},

	ruff = {
		on_attach = function(client, _)
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

local setup = {
	capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		-- for nil_ls
		{ workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
	),
}

return {
	{
		"nvim-lspconfig",
		event = require("getchoo.utils").lazy_file,
		keys = {
			{ "<leader>e", vim.diagnostic.open_float },
			{ "[d", vim.diagnostic.goto_prev },
			{ "]d", vim.diagnostic.goto_next },
			{ "<leader>u", vim.diagnostic.setloclist },
			{ "<leader>ca", vim.lsp.buf.code_action },
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

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("getchoo.lsp", {}),
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

					if client:supports_method("textDocument/completion") then
						vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
					end

					if
						not client:supports_method("textDocument/willSaveWaitUntil")
						and client:supports_method("textDocument/formatting")
					then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("getchoo.lsp", { clear = false }),
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end,
						})
					end
				end,
			})
		end,
	},
}
