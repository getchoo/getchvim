{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";

        devshell.follows = "";
        flake-compat.follows = "";
        git-hooks.follows = "";
        home-manager.follows = "";
        nix-darwin.follows = "";
        treefmt-nix.follows = "";
      };
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./dev ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        {
          pkgs,
          inputs',
          self',
          ...
        }:
        {
          packages = {
            getchvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
              inherit pkgs;
              module = import ./nixvim;
            };

            default = self'.packages.getchvim;
          };
        };

    };
}
