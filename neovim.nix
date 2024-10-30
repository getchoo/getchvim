{
  mkNeovimDerivation,
  getchoo-neovim-config,
  version,

  actionlint,
  glow,
  nil,
  nixfmt-rfc-style,
  nodePackages,
  shellcheck,
  shfmt,
  statix,
  typos-lsp,
  vimPlugins,
  writeTextDir,
}:

mkNeovimDerivation {
  pname = "getchvim";
  inherit version;

  luaRc = writeTextDir "init.lua" "require('getchoo')" + "/init.lua";

  runtimePrograms = [
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

  luaPluginPackages =
    luaPackages: with luaPackages; [
      lz-n
    ];

  vimPluginPackages = with vimPlugins; [
    getchoo-neovim-config

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
}
