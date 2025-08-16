{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
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
          # YYYY
          year = lib.substring 0 4 self.lastModifiedDate;
          # MM
          month = lib.substring 4 2 self.lastModifiedDate;
          # DD
          day = lib.substring 6 2 self.lastModifiedDate;
        in
        lib.concatStringsSep "-" [
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

      overlays.default = final: prev: {
        getchvim = final.callPackage ./neovim.nix { inherit version; };
        mkNeovimWrapper = final.callPackage ./wrapper.nix { };

        vimPlugins = prev.vimPlugins.extend (
          final': _: {
            getchoo = final.vimUtils.buildVimPlugin {
              pname = "getchoo";
              inherit version;

              src = lib.fileset.toSource {
                root = ./.;
                fileset = lib.fileset.unions [
                  ./lua
                  ./ftdetect
                  ./ftplugin
                ];
              };

              doCheck = false;
            };
          }
        );
      };

      packages = forAllSystems (
        system:

        let
          pkgs = nixpkgsFor.${system};

          packageSet = lib.makeScope pkgs.newScope (
            final: { inherit (pkgs) vimUtils vimPlugins; } // self.overlays.default final pkgs
          );
        in

        {
          inherit (packageSet) getchvim;
          default = self.packages.${system}.getchvim;
        }
      );
    };
}
