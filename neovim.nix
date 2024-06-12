{
  lib,
  neovimUtils,
  vimPlugins,
  wrapNeovimUnstable,
  neovim-unwrapped,
  actionlint,
  alejandra,
  beautysh,
  ripgrep,
  efm-langserver,
  nil,
  nodePackages,
  shellcheck,
  statix,
  typos-lsp,
  vimPlugins-getchoo-nvim,
  ...
}: let
  plugins = with vimPlugins; [
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

    dressing-nvim

    efmls-configs-nvim

    fidget-nvim
    flash-nvim
    gitsigns-nvim

    indent-blankline-nvim

    lsp-format-nvim
    nvim-lspconfig

    lualine-nvim

    mini-nvim

    telescope-nvim
    # dependent on >
    plenary-nvim

    nvim-treesitter.withAllGrammars
    nvim-ts-context-commentstring
    nvim-ts-autotag

    trouble-nvim
    which-key-nvim
  ];

  extraPackages = [
    # cmp
    ripgrep

    # efmls-configs
    efm-langserver
    nodePackages.alex
    actionlint
    beautysh
    statix

    # lspconfig
    nodePackages.bash-language-server
    shellcheck
    nil
    alejandra
    typos-lsp
  ];

  neovimConfig = neovimUtils.makeNeovimConfig {
    plugins = plugins ++ [vimPlugins-getchoo-nvim];
  };
in
  wrapNeovimUnstable neovim-unwrapped (
    neovimConfig
    // {
      luaRcContent = ''
        require("getchoo")
      '';

      wrapperArgs =
        neovimConfig.wrapperArgs
        ++ ["--suffix" "PATH" ":" "${lib.makeBinPath extraPackages}"];
    }
  )
