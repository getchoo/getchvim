{
  lib,
  emptyFile,
  lua,
  makeBinaryWrapper,
  neovim-unwrapped,
  neovimUtils,
  runCommand,
  writeText,
}:
{
  pname ? lib.removeSuffix "-unwrapped" neovim-unwrapped.pname,
  version ? neovim-unwrapped.version,
  name ? "${pname}-${version}",
  makeWrapperArgs ? [ ],
  luaPluginPackages ? _: [ ],
  vimPluginPackages ? [ ],
  runtimePrograms ? [ ],
  luaRc ? emptyFile,
  ...
}:

let
  luaEnv = lua.withPackages luaPluginPackages;

  normalizedPlugins = neovimUtils.normalizePlugins vimPluginPackages;
  neovimPackage = neovimUtils.normalizedPluginsToVimPackage normalizedPlugins;
  packDir = neovimUtils.packDir { inherit neovimPackage; };

  vendorRc = writeText "vendor.vim" ''
    lua package.path = "${luaEnv.luaPath}"; package.cpath = "${luaEnv.luaCpath}"
    set packpath^=${packDir} | set runtimepath^=${packDir}
    luafile ${luaRc}
  '';

  flags = [
    "-u"
    (toString vendorRc)
  ];
in
runCommand name
  {
    __structuredAttrs = true;

    nativeBuildInputs = [ makeBinaryWrapper ];

    makeWrapperArgs = makeWrapperArgs ++ [
      "--add-flags"
      (lib.escapeShellArgs flags)
      "--suffix"
      "PATH"
      ":"
      (lib.makeBinPath runtimePrograms)
    ];

    passthru = {
      inherit luaEnv;
    };

    meta = {
      inherit (neovim-unwrapped.meta) description mainProgram;
    };
  }
  ''
    makeWrapper ${lib.getExe neovim-unwrapped} $out/bin/nvim "''${makeWrapperArgs[@]}"
  ''
