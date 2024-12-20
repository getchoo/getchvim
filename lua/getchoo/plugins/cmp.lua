return {
	{
		"nvim-cmp",
		event = require("getchoo.utils").lazy_file,
		after = function()
			local cmp = require("cmp")

			cmp.setup({
				completion = {
					compleopt = "menu,menuone,insert",
				},

				mapping = {
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,

						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					}),
				},

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "async_path" },
					{ name = "buffer" },
				}),
			})
		end
	}
}
