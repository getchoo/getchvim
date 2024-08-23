{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    vim-tera = {
      url = "github:vkhitrin/vim-tera";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      vim-tera,
    }:
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
                cd ${self}

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

      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};

          dateFrom =
            flake:
            let
              # YYYYMMDD
              date = builtins.substring 0 8 flake.lastModifiedDate;
              # YYYY
              year = builtins.substring 0 4 date;
              # MM
              month = builtins.substring 4 2 date;
              # DD
              day = builtins.substring 6 2 date;
            in
            builtins.concatStringsSep "-" [
              year
              month
              day
            ];

        in
        {
          getchvim = pkgs.callPackage (self + "/neovim.nix") {
            inherit (self.packages.${system}) getchoo-neovim-config vim-tera;
          };

          getchoo-neovim-config = pkgs.vimUtils.buildVimPlugin {
            pname = "getchoo-neovim-config";
            version = "0-unstable-" + dateFrom self;

            src = self;
          };

          vim-tera = pkgs.vimUtils.buildVimPlugin {
            pname = "vim-tera";
            version = "0-unstable-" + dateFrom vim-tera;
            src = vim-tera;
          };

          default = self.packages.${system}.getchvim;
        }
      );
    };
}
