{
  mkNeovimWrapper,
  version,

  actionlint,
  bash-language-server,
  deadnix,
  harper,
  nil,
  nixfmt,
  shellcheck,
  shfmt,
  typos-lsp,
  vimPlugins,
  writeText,
}:

mkNeovimWrapper {
  pname = "getchvim";
  inherit version;

  luaRc = writeText "init.lua" "require('getchoo')";

  runtimePrograms = [
    # LSP
    ## General
    typos-lsp
    harper

    ## Language-specific
    bash-language-server
    shellcheck
    shfmt
    nil
    nixfmt

    # Linters
    actionlint
    deadnix
  ];

  vimPluginPackages = with vimPlugins; [
    lz-n
    getchoo

    nvim-treesitter.withAllGrammars
    catppuccin-nvim
    fidget-nvim
    gitsigns-nvim
    nvim-lint
    nvim-lspconfig
    plenary-nvim
    telescope-nvim
    trouble-nvim
  ];
}
