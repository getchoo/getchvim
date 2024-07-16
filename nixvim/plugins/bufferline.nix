{ lib, ... }:
let
  applyDefaultOpts = map (
    lib.recursiveUpdate {
      mode = "n";
      options = {
        noremap = true;
        silent = true;
      };
    }
  );
in
{
  keymaps =
    applyDefaultOpts [
      {
        action = "BufferLinePickClose";
        key = "<leader>q";
      }
    ]
    ++ map (i: {
      action = "BufferLineGoToBuffer ${toString i}";
      key = "<leader>${toString i}";
    }) (lib.range 1 9);

  plugins.bufferline = {
    enable = true;

    alwaysShowBufferline = false;
    diagnostics = "nvim_lsp";
    mode = "buffers";
    numbers = "ordinal";
    separatorStyle = "slant";
  };
}
