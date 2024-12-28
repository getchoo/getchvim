{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-filter.url = "github:numtide/nix-filter";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-filter,
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

      date =
        let
          # YYYYMMDD
          date = builtins.substring 0 8 self.lastModifiedDate;
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
      version = "0-unstable-" + date;
    in
    {
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};

          mkCheck =
            name: deps: script:
            pkgs.runCommand name { nativeBuildInputs = deps; } ''
              ${script}
              touch $out
            '';
        in
        {
          actionlint = mkCheck "check-actionlint" [ pkgs.actionlint ] "actionlint ${./.github/workflows}/*";
          deadnix = mkCheck "check-deadnix" [ pkgs.deadnix ] "deadnix --fail ${self}";
          selene = mkCheck "check-selene" [ pkgs.selene ] "cd ${self} && selene .";
          statix = mkCheck "check-statix" [ pkgs.statix ] "statix check ${self}";
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

          ourPackages = lib.makeScope pkgs.newScope (final: {
            mkNeovimDerivation = final.callPackage ./wrapper.nix { };
            getchvim = final.callPackage ./neovim.nix { inherit version; };

            getchoo-neovim-config = pkgs.vimUtils.buildVimPlugin {
              pname = "getchoo-neovim-config";
              inherit version;

              src = nix-filter.lib.filter {
                root = self;
                include = [
                  ./lua
                  ./ftdetect
                  ./ftplugin
                ];
              };

              doCheck = false;
            };
          });
        in
        {
          inherit (ourPackages) getchvim getchoo-neovim-config;
          default = self.packages.${system}.getchvim;
        }
      );
    };
}
