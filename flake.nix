{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };

    neovim-nix = {
      url = "github:willruggiano/neovim.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "parts";
        pre-commit-nix.follows = "pre-commit";
        neovim.follows = "neovim";
      };
    };

    pre-commit = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
        flake-utils.follows = "utils";
      };
    };

    # this is to prevent multiple versions in lockfile
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {parts, ...} @ inputs:
    parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.pre-commit.flakeModule
        inputs.neovim-nix.flakeModule
        ./neovim.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        config,
        self',
        ...
      }: {
        packages = {
          getchvim = config.neovim.final;
          default = self'.packages.getchvim;
        };

        devShells.default = pkgs.mkShell {
          shellHook = config.pre-commit.installationScript;

          packages = with pkgs; [
            actionlint
            self'.formatter
            deadnix
            nil
            statix
            stylua
          ];
        };

        formatter = pkgs.alejandra;

        pre-commit.settings.hooks = {
          actionlint.enable = true;
          alejandra.enable = true;
          deadnix.enable = true;
          nil.enable = true;
          statix.enable = true;
          stylua.enable = true;
        };
      };
    };
}
