{self, ...}: {
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: let
    plugins = with pkgs.vimPlugins;
      [
        # general
        catppuccin-nvim

        # TODO: don't pin when deprecation notice
        # is no longer in nixpkgs
        (fidget-nvim.overrideAttrs (_: {
          src = pkgs.fetchFromGitHub {
            owner = "j-hui";
            repo = "fidget.nvim";
            rev = "41f327b53c7977d47aee56f05e0bdbb4b994c5eb";
            hash = "sha256-v9qARsW8Gozit4Z3+igiemjI467QgRhwM+crqwO9r6U=";
          };
        }))

        flash-nvim
        gitsigns-nvim
        indent-blankline-nvim
        lualine-nvim
        neo-tree-nvim
        nvim-web-devicons
        mini-nvim

        # completion
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp_luasnip
        cmp-async-path
        luasnip

        # ui
        dressing-nvim
        noice-nvim
        nui-nvim
        nvim-notify

        # lsp
        nvim-lspconfig
        null-ls-nvim

        # utils
        bufferline-nvim
        plenary-nvim
        telescope-nvim
        trouble-nvim
        which-key-nvim

        # treesitter
        nvim-treesitter.withAllGrammars
        nvim-ts-context-commentstring

        # main config
        self'.packages.getchvim
      ]
      ++ lib.optional (pkgs ? vim-just) pkgs.vim-just;

    extraPrograms = with pkgs; [
      # external tools
      fd
      git
      ripgrep
      just

      # lint
      actionlint
      codespell
      deadnix
      nodePackages.alex
      shellcheck
      statix

      # format
      alejandra
      beautysh
      stylua

      # lsp
      nil
      sumneko-lua-language-server
    ];

    customRC = ''
      lua require("getchoo")
    '';

    config = pkgs.neovimUtils.makeNeovimConfig {
      withPython3 = true;
      withRuby = false;
      inherit plugins;
      inherit customRC;
    };
  in {
    packages = {
      default = self'.packages.neovim;

      neovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
        config
        // {
          wrapperArgs =
            (lib.escapeShellArgs config.wrapperArgs)
            + " "
            + ''--suffix PATH : "${lib.makeBinPath extraPrograms}"'';
        }
      );

      getchvim = pkgs.vimUtils.buildVimPlugin {
        pname = "getchvim";
        version = builtins.substring 0 8 self.lastModifiedDate or "dirty";

        src = lib.cleanSource ./.;
      };
    };
  };
}
