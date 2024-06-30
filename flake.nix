{
  description = "getchoo's neovim config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      nixpkgsFor = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          check-formatting =
            pkgs.runCommand "check-formatting"
              {
                nativeBuildInputs = [
                  pkgs.actionlint
                  pkgs.nixfmt-rfc-style
                  pkgs.stylua
                ];
              }
              ''
                cd ${./.}

                echo "running actionlint..."
                actionlint ./.github/workflows/*

                echo "running nixfmt..."
                nixfmt --check .

                echo "running stylua..."
                stylua --check .

                touch $out
              '';

          check-lint =
            pkgs.runCommand "check-lint"
              {
                nativeBuildInputs = [
                  pkgs.selene
                  pkgs.statix
                ];
              }
              ''
                cd ${./.}

                echo "running selene..."
                selene .

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

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};

          packages' = self.packages.${system};
          version = self.shortRev or self.dirtyShortRev or "unknown";
        in
        {
          getchvim = pkgs.callPackage ./neovim.nix {
            inherit version;
            inherit (packages') vimPlugins-getchoo-nvim;
          };

          vimPlugins-getchoo-nvim = pkgs.callPackage ./config { inherit version; };

          default = packages'.getchvim;
        }
      );
    };
}
