{
  plugins = {
    nvim-cmp = {
      enable = true;

      completion = {
        completeopt = "menu,menuone,noinsert";
      };

      mapping = {
        "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })";
        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.abort()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true})";
      };

      snippet.expand = "luasnip";

      sources = map (name: {inherit name;}) [
        "nvim_lsp"
        "luasnip"
        "path"
        "buffer"
        "rg"
      ];
    };
  };
}
