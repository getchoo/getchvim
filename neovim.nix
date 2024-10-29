{
  lib,
  actionlint,
  glow,
  neovim-unwrapped,
  neovimUtils,
  nil,
  nixfmt-rfc-style,
  nodePackages,
  shellcheck,
  shfmt,
  statix,
  typos-lsp,
  vimPlugins,
  wrapNeovimUnstable,

  getchoo-neovim-config,
}:

let
  plugins = with vimPlugins; [
    getchoo-neovim-config

    # lazy loader
    lz-n

    # Editing
    flash-nvim
    glow-nvim
    mini-nvim

    nvim-treesitter.withAllGrammars

    # UI
    catppuccin-nvim
    indent-blankline-nvim
    lualine-nvim

    # Coding
    nvim-cmp
    luasnip
    cmp-async-path
    cmp-buffer
    cmp-nvim-lsp

    crates-nvim
    gitsigns-nvim
    nvim-lint
    telescope-nvim # dependent on >
    plenary-nvim

    # LSP
    fidget-nvim
    lsp-format-nvim
    nvim-lspconfig
    trouble-nvim
  ];

  extraPackages = [
    # External programs
    glow

    # LSP
    ## General
    typos-lsp

    ## Language-specific
    nodePackages.bash-language-server
    shellcheck
    shfmt
    nil
    nixfmt-rfc-style

    # Linters
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
