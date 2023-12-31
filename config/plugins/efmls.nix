{
  plugins = {
    lsp.servers.efm.extraOptions = {
      init_options = {
        documentFormatting = true;
        documentRangeFormatting = true;
      };
    };

    efmls-configs = {
      enable = true;

      setup = {
        all = {
          linter = [
            "alex"
            "codespell"
          ];
        };

        bash = {
          formatter = "beautysh";
          linter = "shellcheck";
        };

        css = {
          formatter = "prettier";
        };

        fish = {
          formatter = "fish_indent";
        };

        html = {
          formatter = "prettier";
        };

        json = {
          formatter = "prettier";
        };

        lua = {
          formatter = "stylua";
        };

        nix = {
          linter = "statix";
        };

        sass = {
          formatter = "prettier";
        };

        scss = {
          formatter = "prettier";
        };

        sh = {
          formatter = ["beautysh" "shellharden"];
          linter = "shellcheck";
        };

        yaml = {
          formatter = "prettier";
          linter = "actionlint";
        };

        zsh = {
          formatter = "beautysh";
        };
      };
    };
  };
}
