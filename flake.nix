{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-checks.url = "github:getchoo/flake-checks";
  };

  outputs = {
    self,
    nixpkgs,
    flake-checks,
  }: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = fn:
      nixpkgs.lib.genAttrs systems (system:
        fn {
          inherit system;
          pkgs = nixpkgs.legacyPackages.${system};
        });
  in {
    checks = forAllSystems ({pkgs, ...}: let
      flake-checks' = flake-checks.lib.mkChecks {
        root = ./.;
        inherit pkgs;
      };
    in {
      inherit
        (flake-checks')
        actionlint
        alejandra
        selene
        statix
        stylua
        ;
    });

    devShells = forAllSystems ({
      pkgs,
      system,
    }: {
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
    });

    formatter = forAllSystems ({pkgs, ...}: pkgs.alejandra);

    packages = forAllSystems ({
      pkgs,
      system,
    }: let
      packages' = self.packages.${system};
      version = self.shortRev or self.dirtyShortRev or "unknown";
    in {
      getchvim = pkgs.callPackage ./neovim.nix {
        inherit version;
        inherit (packages') vimPlugins-getchoo-nvim;
      };

      vimPlugins-getchoo-nvim = pkgs.callPackage ./config {
        inherit version;
      };

      default = packages'.getchvim;
    });
  };
}
