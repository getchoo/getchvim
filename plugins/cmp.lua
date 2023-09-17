return function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local mapping = cmp.mapping

	return {
		completion = {
			completeopt = "menu,menuone,noinsert",
		},

		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},

		mapping = mapping.preset.insert({
			["<C-n>"] = mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-b>"] = mapping.scroll_docs(-4),
			["<C-f>"] = mapping.scroll_docs(4),
			["<C-Space>"] = mapping.complete(),
			["<C-e>"] = mapping.abort(),
			["<CR>"] = mapping.confirm({ select = true }),
			["<S-CR>"] = mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
		}),

		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "async_path" },
			{ name = "buffer" },
		}),
	}
end
