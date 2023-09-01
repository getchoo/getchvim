{
  lib,
  buildVimPluginFrom2Nix,
  self,
  version,
}: let
  filter = path: type: let
    path' = toString path;
    base = baseNameOf path';
    isLua = lib.any (suffix: lib.hasSuffix suffix base) [".lua"];
  in
    type == "directory" || isLua;

  filterSource = src:
    lib.cleanSourceWith {
      src = lib.cleanSource self;
      inherit filter;
    };
in
  buildVimPluginFrom2Nix {
    pname = "getchvim";
    inherit version;
    src = filterSource self;
    meta = with lib; {
      homepage = "https://github.com/getchoo/getchvim";
      license = licenses.mit;
      maintainers = with maintainers; [getchoo];
      platforms = platforms.all;
    };
  }
