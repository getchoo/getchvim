{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";
    utils.url = "https://flakehub.com/f/numtide/flake-utils/0.1.88.tar.gz";

    nixvim = {
      url = "https://flakehub.com/f/nix-community/nixvim/0.1.*.tar.gz";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "utils";
        pre-commit-hooks.follows = "";
      };
    };

    tree-sitter-just = {
      url = "github:IndianBoy42/tree-sitter-just";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    utils,
    nixvim,
    tree-sitter-just,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (pkgs) lib;
    in rec {
      checks = {
        check-actionlint =
          pkgs.runCommand "check-actionlint" {
            nativeBuildInputs = [pkgs.actionlint];
          } ''
            actionlint ${./.}/.github/workflows/*
            touch $out
          '';

        "check-${formatter.pname}" =
          pkgs.runCommand "check-${formatter.pname}" {
            nativeBuildInputs = [formatter];
          } ''
            ${lib.getExe formatter} --check ${./.}
            touch $out
          '';

        check-statix =
          pkgs.runCommand "check-statix" {
            nativeBuildInputs = [pkgs.statix];
          }
          ''
            statix check ${./.}
            touch $out
          '';

        check-nil =
          pkgs.runCommand "check-nil" {
            nativeBuildInputs = with pkgs; [fd git nil];
          }
          ''
            cd ${./.}
            fd . -e 'nix' | while read -r file; do
              nil diagnostics "$file"
            done

            touch $out
          '';
      };

      devShells = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            actionlint
            formatter
            deadnix
            nil
            statix
          ];
        };
      };

      formatter = pkgs.alejandra;

      packages = {
        nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
          module = ./config;
          extraSpecialArgs = {self = packages;};
        };

        tree-sitter-just = pkgs.tree-sitter.buildGrammar {
          language = "just";
          version = builtins.substring 0 8 tree-sitter-just.lastModifiedDate;
          src = tree-sitter-just;
        };

        default = packages.nvim;
      };
    });
}
