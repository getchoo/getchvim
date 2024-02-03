self: {
  lib,
  pkgs,
  ...
}: let
  config = pkgs.vimUtils.buildVimPlugin {
    pname = "neovim-config";
    version = builtins.substring 0 8 self.rev or self.dirtyRev or "dirty";

    src = null;

    dontUnpack = true;

    buildPhase = ''
      mkdir -p lua
      cp -r ${./config} lua/getchoo
    '';
  };

  plugins = with pkgs.vimPlugins; [
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
    vim-just

    trouble-nvim
    which-key-nvim
  ];

  extraPackages = with pkgs; [
    # cmp
    ripgrep

    # efmls-configs
    efm-langserver
    nodePackages.alex
    actionlint
    beautysh
    codespell
    shellcheck
    statix

    # lspconfig
    nodePackages.bash-language-server
    nil
    alejandra
  ];

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = true;
    withRuby = false;
    plugins = plugins ++ [config];
    customRC = ''
      lua require("getchoo")
    '';
  };
in
  pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (lib.recursiveUpdate
    neovimConfig
    {
      wrapperArgs =
        lib.escapeShellArgs neovimConfig.wrapperArgs
        + " "
        + ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
    })
