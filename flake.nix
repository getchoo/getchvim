{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = lib.genAttrs systems;
      nixpkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
          fs = lib.fileset;

          root = fs.toSource {
            root = ./.;
            fileset = fs.unions [
              # ci workflows
              ./.github

              # lua configuration
              ./after
              ./ftdetect
              ./lua
              ./plugin
              ./selene.toml
              ./nvim.yaml

              # nix
              ./flake.nix
              ./neovim.nix
            ];
          };
        in
        {
          check-format-and-lint =
            pkgs.runCommand "check-format-and-lint"
              {
                nativeBuildInputs = [
                  pkgs.actionlint
                  pkgs.nixfmt-rfc-style
                  pkgs.selene
                  pkgs.statix
                ];
              }
              ''
                cd ${root}

                echo "running actionlint..."
                actionlint ./.github/workflows/*

                echo "running nixfmt..."
                nixfmt --check .

                echo "running selene...."
                selene **/*.lua

                echo "running statix..."
                statix check .

                touch $out
              '';

        }
      );

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              pkgs.actionlint

              # lua
              pkgs.lua-language-server
              pkgs.selene
              pkgs.stylua

              # nix
              self.formatter.${system}
              pkgs.deadnix
              pkgs.nil
              pkgs.statix
            ];
          };
        }
      );

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt-rfc-style);

      packages = forAllSystems (system: {
        getchvim = nixpkgsFor.${system}.callPackage ./neovim.nix {
          version = self.shortRev or self.dirtyShortRev or "unknown";
        };

        default = self.packages.${system}.getchvim;
      });
    };
}
