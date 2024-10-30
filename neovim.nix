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

      # Coding
      nvim-cmp

      # LSP
      fidget-nvim
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
    cmp-async-path
    cmp-buffer
    cmp-nvim-lsp

    crates-nvim
    ## TODO: Use luarocks plugin when it's not broken
    gitsigns-nvim
    nvim-lint
    ## TODO: Ditto
    telescope-nvim # dependent on >
    plenary-nvim

    # LSP
    lsp-format-nvim
    nvim-lspconfig
    trouble-nvim
  ];
}
