{
  lib,
  neovimUtils,
  vimPlugins,
  wrapNeovimUnstable,
  neovim-unwrapped,
  actionlint,
  getchoo-neovim-config,
  glow,
  nil,
  nixfmt-rfc-style,
  nodePackages,
  shellcheck,
  shfmt,
  statix,
  typos-lsp,
}:
let
  plugins = with vimPlugins; [
    getchoo-neovim-config

    # coding
    nvim-cmp
    luasnip
    cmp-async-path
    cmp-buffer
    cmp-nvim-lsp

    crates-nvim
    gitsigns-nvim
    nvim-lint

    # editing
    flash-nvim
    glow-nvim
    mini-nvim

    telescope-nvim # dependent on >
    plenary-nvim

    nvim-treesitter.withAllGrammars

    # ui
    catppuccin-nvim
    indent-blankline-nvim
    lualine-nvim

    # lsp
    fidget-nvim
    lsp-format-nvim
    nvim-lspconfig
    trouble-nvim
  ];

  extraPackages = [
    glow

    # lsp
    nodePackages.bash-language-server
    shellcheck
    shfmt

    nil
    nixfmt-rfc-style

    typos-lsp

    # linters
    nodePackages.alex
    actionlint
    statix
  ];

  baseConfig = neovimUtils.makeNeovimConfig {
    withRuby = false;
    inherit plugins;
  };

  config = baseConfig // {
    luaRcContent = "require('getchoo')";
    wrapperArgs = baseConfig.wrapperArgs ++ [
      "--suffix"
      "PATH"
      ":"
      "${lib.makeBinPath extraPackages}"
    ];
  };
in
wrapNeovimUnstable neovim-unwrapped config
