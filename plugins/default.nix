{pkgs, ...}: let
  inherit (pkgs) vimPlugins;
in rec {
  config = {
    src = ../config;
    lazy = false;
    priority = 1000;
  };

  catppuccin-nvim = {
    package = vimPlugins.catppuccin-nvim;

    config = ./catppuccin.lua;
  };

  fidget-nvim = {
    package = vimPlugins.fidget-nvim.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        owner = "j-hui";
        repo = "fidget.nvim";
        rev = "41f327b53c7977d47aee56f05e0bdbb4b994c5eb";
        hash = "sha256-v9qARsW8Gozit4Z3+igiemjI467QgRhwM+crqwO9r6U=";
      };
    });
  };

  flash-nvim = {
    package = vimPlugins.flash-nvim;
    event = "VeryLazy";
  };

  gitsigns-nvim = {
    package = vimPlugins.gitsigns-nvim;
    event = ["BufReadPre" "BufNewFile"];
  };

  indent-blankline-nvim = {
    package = vimPlugins.indent-blankline-nvim;

    event = ["BufReadPost" "BufNewFile"];

    config = {
      filetype_exclude = [
        "help"
        "neo-tree"
        "Trouble"
        "lazy"
        "mason"
        "notify"
        "toggleterm"
      ];
      show_trailing_blankline_indent = false;
      show_current_context = false;
    };
  };

  lualine-nvim = {
    package = vimPlugins.lualine-nvim;

    event = "VeryLazy";

    dependencies = {
      nvim-web-devicons.package = vimPlugins.nvim-web-devicons;
    };

    config = ./lualine.lua;
  };

  neo-tree-nvim = {
    package = vimPlugins.neo-tree-nvim;
    dependencies = {
      plenary-nvim.package = vimPlugins.plenary-nvim;
      inherit (lualine-nvim.dependencies) nvim-web-devicons;
      inherit nui-nvim;
    };

    config = ./neo-tree.lua;
  };

  # TODO: configure mini.pairs, mini.indentscope, & mini.comment
  mini-nvim.package = vimPlugins.mini-nvim;

  nvim-cmp = {
    package = vimPlugins.nvim-cmp;
    dependencies = {
      cmp-nvim-lsp.package = vimPlugins.cmp-nvim-lsp;
      cmp-buffer.package = vimPlugins.cmp-buffer;
      cmp_luasnip.package = vimPlugins.cmp_luasnip;
      cmp-async-path.package = vimPlugins.cmp-async-path;
      luasnip.package = vimPlugins.luasnip;
    };

    event = "InsertEnter";
    config = ./cmp.lua;
  };

  dressing-nvim = {
    package = vimPlugins.dressing-nvim;
    lazy = true;
    init = ./dressing.lua;
  };

  noice-nvim = {
    package = vimPlugins.noice-nvim;
    event = "VeryLazy";

    config = ./noice.lua;
  };

  nui-nvim = {
    package = vimPlugins.nui-nvim;
    lazy = true;
  };

  nvim-lspconfig = {
    package = vimPlugins.nvim-lspconfig;

    event = ["BufReadPre" "BufNewFile"];
    config = ./lspconfig.lua;
  };

  nvim-treesitter = {
    package = vimPlugins.nvim-treesitter.withAllGrammars;
    dependencies = {
      nvim-ts-context-commentstring.package = vimPlugins.nvim-ts-context-commentstring;
    };

    event = ["BufReadPost" "BufNewFile"];
    config = {
      auto_install = false;
      highlight.enable = true;
      indent.enable = true;
      context_commentstring = {
        enable = true;
        enable_autocmd = false;
      };
    };
  };

  null-ls = {
    package = vimPlugins.null-ls-nvim;
    dependencies = {
      inherit (neo-tree-nvim.dependencies) plenary-nvim;
    };

    config = ./null-ls.lua;
  };

  bufferline-nvim = {
    package = vimPlugins.bufferline-nvim;
    dependencies = {
      inherit (lualine-nvim.dependencies) nvim-web-devicons;
      inherit catppuccin-nvim;
    };

    config = ./bufferline.lua;
  };

  telescope-nvim.package = vimPlugins.telescope-nvim;

  trouble-nvim = {
    package = vimPlugins.trouble-nvim;
    dependencies = {
      inherit (lualine-nvim.dependencies) nvim-web-devicons;
    };
  };

  which-key-nvim = {
    package = vimPlugins.which-key-nvim;
    event = "VeryLazy";
    config = {
      plugins = {
        spelling = true;
      };
    };
  };
}
