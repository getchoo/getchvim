{
  description = "getchoo's neovim config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    inherit (nixpkgs) lib;
    version = builtins.substring 0 8 self.lastModifiedDate or "dirty";

    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    genSystems = lib.genAttrs systems;
    nixpkgsFor = genSystems (sys: nixpkgs.legacyPackages.${sys});
    forAllSystems = fn: genSystems (sys: fn nixpkgsFor.${sys});

    packageFn = pkgs: {
      getchvim =
        pkgs.callPackage (
          {
            lib,
            buildVimPluginFrom2Nix,
            self,
            version,
          }:
            buildVimPluginFrom2Nix {
              pname = "getchvim";
              inherit version;
              src = lib.cleanSource self;
              meta = with lib; {
                homepage = "https://github.com/getchoo/getchvim";
                license = licenses.mit;
                maintainers = with maintainers; [getchoo];
                platforms = platforms.all;
              };
            }
        ) {
          inherit self version;
          inherit (pkgs.vimUtils) buildVimPluginFrom2Nix;
        };
    };
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          stylua
        ];
      };
    });

    formatter = forAllSystems (p: p.alejandra);

    packages = forAllSystems (pkgs: let
      p = packageFn pkgs;
    in {
      inherit (p) getchvim;
      default = p.getchvim;
    });

    overlays.default = _: prev: {
      vimPlugins = prev.vimPlugins.extend (_: _: packageFn prev);
    };
  };
}
