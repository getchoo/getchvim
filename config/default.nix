{
  lib,
  vimUtils,
  version,
}:
vimUtils.buildVimPlugin {
  pname = "neovim-config";
  inherit version;

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./after
      ./ftdetect
      ./lua
      ./plugin
    ];
  };
}
