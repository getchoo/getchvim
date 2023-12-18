{
  pkgs,
  self,
  ...
}: {
  extraPlugins = [pkgs.vimPlugins.vim-just];

  plugins = {
    treesitter = {
      enable = true;

      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars ++ [self.tree-sitter-just];

      indent = true;
      nixvimInjections = true;
    };

    ts-context-commentstring = {
      enable = true;
      disableAutoInitialization = true;
    };

    ts-autotag.enable = true;
  };
}
