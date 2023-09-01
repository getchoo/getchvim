{
  description = "getchoo's neovim config";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

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

    forAllSystems = fn: lib.genAttrs systems (sys: fn nixpkgs.legacyPackages.${sys});
  in {
    devShells = forAllSystems (pkgs: {
      default = import ./shell.nix {inherit pkgs;};
    });

    formatter = forAllSystems (pkgs: pkgs.alejandra);

    packages = forAllSystems (pkgs: let
      p = self.overlays.default pkgs pkgs;
    in {
      inherit (p.vimPlugins) getchvim;
      default = p.vimPlugins.getchvim;
    });

    overlays.default = final: prev: {
      vimPlugins = prev.vimPlugins.extend (_: _: {
        getchvim = prev.callPackage ./default.nix {
          inherit (final.vimUtils) buildVimPluginFrom2Nix;
          inherit self version;
        };
      });
    };
  };
}
