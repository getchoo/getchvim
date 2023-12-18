{
  plugins = {
    lsp.servers.efm.extraOptions = {
      init_options.documentFormatting = true;
    };

    efmls-configs = {
      enable = true;

      externallyManagedPackages = [
        "eslintd"
        "isort"
        "mypy"
        "prettierd"
        "prettier_eslint"
        "pylint"
        "ruff"
        "rustfmt"
      ];

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
          formatter = "prettier_d";
        };

        fish = {
          formatter = "fish_indent";
        };

        html = {
          formatter = "prettier_d";
        };

        javascript = {
          formatter = "prettier_eslint";
          linter = "eslint_d";
        };

        json = {
          formatter = "prettier_d";
        };

        lua = {
          formatter = "stylua";
        };

        nix = {
          formatter = "alejandra";
          linter = "statix";
        };

        python = {
          formatter = [
            "ruff"
            "isort"
          ];

          linter = [
            "mypy"
            "pylint"
          ];
        };

        rust = {
          formatter = "rustfmt";
        };

        sass = {
          formatter = "prettier_d";
        };

        scss = {
          formatter = "prettier_d";
        };

        sh = {
          formatter = ["beautysh" "shellharden"];
          linter = "shellcheck";
        };

        typescript = {
          formatter = "prettier_eslint";
          linter = "eslint_d";
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
