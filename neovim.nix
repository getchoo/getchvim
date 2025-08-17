{
  mkNeovimWrapper,
  version,

  actionlint,
  bash-language-server,
  glow,
  harper,
  lua,
  nixd,
  nixfmt,
  nodePackages,
  shellcheck,
  shfmt,
  statix,
  typos-lsp,
  vimPlugins,
  writeText,
}:

mkNeovimWrapper {
  pname = "getchvim";
  inherit version;

  luaEnv = lua.withPackages (
    p: with p; [
      lz-n

      # Coding
      nvim-cmp

      # LSP
      fidget-nvim
    ]
  );

  luaRc = writeText "init.lua" "require('getchoo')";

  runtimePrograms = [
    # External programs
    glow

    # LSP
    ## General
    typos-lsp
    harper

    ## Language-specific
    bash-language-server
    shellcheck
    shfmt
    nixd
    nixfmt

    # Linters
    nodePackages.alex
    actionlint
    statix
  ];

  vimPluginPackages = with vimPlugins; [
    getchoo

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
