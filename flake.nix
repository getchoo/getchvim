{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.0.tar.gz";

    tree-sitter-just = {
      url = "github:IndianBoy42/tree-sitter-just";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forSystem = system: fn: fn nixpkgs.legacyPackages.${system};
    forAllSystems = fn: nixpkgs.lib.genAttrs systems (system: forSystem system fn);
  in {
    checks = forAllSystems (pkgs: import ./checks.nix {inherit pkgs self;});

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          actionlint

          # lua
          lua-language-server
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

      tree-sitter-just = pkgs.tree-sitter.buildGrammar {
        language = "just";
        version = builtins.substring 0 8 inputs.tree-sitter-just.lastModifiedDate;

        src = inputs.tree-sitter-just;
      };

      default = getchvim;
    });
  };
}
