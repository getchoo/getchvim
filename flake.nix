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

    forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: fn nixpkgs.legacyPackages.${system});
  in {
    checks = forAllSystems (pkgs: let
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

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          actionlint

          # lua
          lua-language-server
          selene
          stylua

          # nix
          self.formatter.${pkgs.system}
          deadnix
          nil
          statix
        ];
      };
    });

    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: rec {
      getchvim = import ./neovim.nix self pkgs;
      default = getchvim;
    });
  };
}
