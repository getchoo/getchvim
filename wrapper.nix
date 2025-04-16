{
  lib,
  stdenv,
  emptyFile,
  lua,
  makeBinaryWrapper,
  neovim-unwrapped,
  neovimUtils,
  writeText,
}:

let
  lua' = lua;

  makeNeovimWrapper = lib.extendMkDerivation {
    constructDrv = stdenv.mkDerivation;

    extendDrvArgs =
      finalAttrs:

      args@{
        version ? neovim-unwrapped.version,
        nativeBuildInputs ? [ ],
        makeWrapperArgs ? [ ],
        passthru ? { },
        meta ? { },

        luaPluginPackages ? [ ],
        vimPluginPackages ? [ ],
        runtimePrograms ? [ ],
        lua ? lua',
        luaRc ? emptyFile,
        ...
      }:

      let
        luaEnv = finalAttrs.lua.withPackages (lib.const finalAttrs.luaPluginPackages);

        normalizedPlugins = neovimUtils.normalizePlugins finalAttrs.vimPluginPackages;
        neovimPackage = neovimUtils.normalizedPluginsToVimPackage normalizedPlugins;
        packDir = neovimUtils.packDir { inherit neovimPackage; };

        vendorRc = writeText "vendor.vim" ''
          lua package.path = "${luaEnv.luaPath}"; package.cpath = "${luaEnv.luaCpath}"
          set packpath^=${packDir} | set runtimepath^=${packDir}
          luafile ${luaRc}
        '';

        # TODO: Pass all flags in one invocation of --add-flags???
        addedFlags =
          lib.concatMap
            (flag: [
              "--add-flags"
              flag
            ])
            [
              "-u"
              vendorRc
            ];
      in

      {
        inherit version;

        nativeBuildInputs = nativeBuildInputs ++ [ makeBinaryWrapper ];

        makeWrapperArgs =
          makeWrapperArgs
          ++ addedFlags
          ++ [
            "--suffix"
            "PATH"
            ":"
            (lib.makeBinPath runtimePrograms)
          ];

        buildCommand =
          args.buildCommand or ''
            concatTo makeWrapperArgsArray makeWrapperArgs
            echoCmd 'mk-neovim-wrapper makeWrapperFlags' "''${makeWrapperArgsArray[@]}"

            makeWrapper ${lib.getExe neovim-unwrapped} $out/bin/nvim "''${makeWrapperArgsArray[@]}"
          '';

        inherit lua luaPluginPackages vimPluginPackages;

        passthru = {
          inherit makeNeovimWrapper;
          inherit luaEnv;
        } // passthru;

        meta = {
          inherit (neovim-unwrapped.meta) description mainProgram;
        } // meta;
      };
  };
in

makeNeovimWrapper
