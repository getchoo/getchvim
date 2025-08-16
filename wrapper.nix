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
  mkNeovimWrapper = lib.extendMkDerivation {
    constructDrv = stdenv.mkDerivation;

    extendDrvArgs =
      finalAttrs:

      {
        pname ? neovim-unwrapped.pname,
        version ? neovim-unwrapped.version,
        nativeBuildInputs ? [ ],
        makeWrapperArgs ? [ ],
        passthru ? { },
        meta ? { },

        runtimePrograms ? [ ],
        luaRc ? emptyFile,
        ...
      }@args:

      let
        luaEnv = finalAttrs.luaEnv or lua.buildEnv;
        vimPluginPackages = finalAttrs.vimPluginPackages or [ ];

        normalizedPlugins = neovimUtils.normalizePlugins vimPluginPackages;
        neovimPackage = neovimUtils.normalizedPluginsToVimPackage normalizedPlugins;
        packDir = neovimUtils.packDir { inherit neovimPackage; };

        vendorRc = writeText "vendor.vim" ''
          lua package.path = "${luaEnv.luaPath}"; package.cpath = "${luaEnv.luaCpath}"
          set packpath^=${packDir} | set runtimepath^=${packDir}
          luafile ${luaRc}
        '';
      in

      {
        inherit pname version;

        nativeBuildInputs = nativeBuildInputs ++ [ makeBinaryWrapper ];

        __structuredAttrs = true;
        makeWrapperArgs = makeWrapperArgs ++ [
          "--add-flags"
          "-u ${vendorRc}"
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

        passthru = {
          inherit mkNeovimWrapper;
        }
        // passthru;

        meta = {
          inherit (neovim-unwrapped.meta) description mainProgram;
        }
        // meta;
      };
  };
in

/**
  Create a wrapper for Neovim

  # Example

  ```
  mkNeovimWrapper { vimPluginPackages = [ pkgs.vimPlugins.nvim-lspconfig ]; }
  => <drv>
  ```

  # Type

  ```
  mkNeovimWrapper :: AttrSet -> Derivation
  ```

  # Arguments

  - [pname]: package name for the wrapper. defaults to the package name of neovim-unwrapped.
  - [version]: package version for the wrapper. defaults to the package version of neovim-unwrapped.
  - [luaRc] (optional): lua configuration file for neovim.
  - [luaEnv] (optional): lua environment to use for the wrapper.
  - [makeWrapperArgs] (optional): list of additional arguments to pass to `makeWrapper`.
  - [runtimePrograms] (optional): list of packages to add to the wrapper's $PATH.
  - [vimPluginPackages] (optional): list of vim plugin packages to add to the wrapper's runtimepath.
  - [...]: all the same arguments as `mkDerivation`.
*/
mkNeovimWrapper
