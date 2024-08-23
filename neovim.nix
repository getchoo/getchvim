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
  ripgrep,
  shellcheck,
  shfmt,
  statix,
  typos-lsp,
  vim-tera,
}:
let
  plugins = with vimPlugins; [
    getchoo-neovim-config

    # coding
    nvim-cmp
    luasnip
    cmp-async-path
    cmp-buffer
    cmp_luasnip
    cmp-nvim-lsp
    cmp-rg

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

    vim-tera

    # ui
    bufferline-nvim # dependent on >
    nvim-web-devicons

    catppuccin-nvim
    indent-blankline-nvim
    lualine-nvim

    # lsp
    fidget-nvim
    nvim-lspconfig
    lsp-format-nvim
    trouble-nvim
  ];

  extraPackages = [
    glow # glow.nvim

    ripgrep # cmp

    # lsp
    nodePackages.bash-language-server
    shellcheck
    shfmt

    nil
    nixfmt-rfc-style

    typos-lsp

    ## linters
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
