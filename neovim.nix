{
  lib,
  neovimUtils,
  vimUtils,
  vimPlugins,
  wrapNeovimUnstable,
  neovim-unwrapped,
  actionlint,
  glow,
  ripgrep,
  nil,
  nixfmt-rfc-style,
  nodePackages,
  shellcheck,
  shfmt,
  statix,
  typos-lsp,
  version,
}:
let
  fs = lib.fileset;
  vimPlugins-getchoo-nvim = vimUtils.buildVimPlugin {
    pname = "getchoo-neovim-config";
    inherit version;

    src = fs.toSource {
      root = ./.;
      fileset = fs.intersection (fs.gitTracked ./.) (
        fs.unions [
          ./after
          ./ftdetect
          ./plugin
        ]
      );
    };
  };

  plugins = with vimPlugins; [
    vimPlugins-getchoo-nvim

    # coding
    nvim-cmp
    luasnip
    cmp-async-path
    cmp-buffer
    cmp_luasnip
    cmp-nvim-lsp
    cmp-rg

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
