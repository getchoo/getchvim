{ helpers, ... }:
{
  plugins.cmp = {
    enable = true;

    settings = {
      completion.completeopt = "menu,menuone,insert";

      snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
      '';

      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = helpers.mkRaw ''
            cmp.mapping({
          	  i = function(fallback)
          	  	if cmp.visible() and cmp.get_active_entry() then
          	  		cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          	  	else
          	  		fallback()
          	  	end
          	  end,

          	  s = cmp.mapping.confirm({ select = true }),
          	  c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            })
        '';
      };

      sources = map (name: { inherit name; }) [
        "nvim_lsp"
        "luasnip"
        "async_path"
        "buffer"
        "rg"
      ];
    };
  };
}
