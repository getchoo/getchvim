{
  lib,
  neovimUtils,
  vimUtils,
  vimPlugins,
  wrapNeovimUnstable,
  neovim-unwrapped,
  actionlint,
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

    bufferline-nvim
    # dependent on >
    nvim-web-devicons
    catppuccin-nvim

    nvim-cmp
    luasnip
    cmp-async-path
    cmp-buffer
    cmp_luasnip
    cmp-nvim-lsp
    cmp-rg

    fidget-nvim
    flash-nvim
    gitsigns-nvim

    indent-blankline-nvim

    nvim-lspconfig
    lsp-format-nvim
    nvim-lint

    lualine-nvim

    mini-nvim

    telescope-nvim
    # dependent on >
    plenary-nvim

    nvim-treesitter.withAllGrammars

    trouble-nvim
  ];

  extraPackages = [
    # cmp
    ripgrep

    # linters
    nodePackages.alex
    actionlint
    statix

    # lspconfig
    nodePackages.bash-language-server
    shellcheck
    shfmt

    nil
    nixfmt-rfc-style

    typos-lsp
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
