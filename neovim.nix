{
  mkNeovimWrapper,
  getchoo-neovim-config,
  version,

  actionlint,
  glow,
  harper,
  nixd,
  nixfmt-rfc-style,
  nodePackages,
  shellcheck,
  shfmt,
  statix,
  vimPlugins,
  writeText,
}:

mkNeovimWrapper (finalAttrs: {
  pname = "getchvim";
  inherit version;

  luaRc = writeText "init.lua" "require('getchoo')";

  runtimePrograms = [
    # External programs
    glow

    # LSP
    ## General
    harper

    ## Language-specific
    nodePackages.bash-language-server
    shellcheck
    shfmt
    nixd
    nixfmt-rfc-style

    # Linters
    nodePackages.alex
    actionlint
    statix
  ];

  luaPluginPackages = with finalAttrs.finalPackage.lua.pkgs; [
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
})
