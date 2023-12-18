{lib, ...}: let
  setBind = lib.recursiveUpdate {
    mode = "n";
    lua = true;
    options = {
      noremap = true;
      silent = true;
    };
  };
in {
  keymaps = map setBind (
    [
      {
        key = "<leader>t";
        action = ''
          function()
            require("neo-tree.command").execute({
              toggle = true,
              dir = vim.loop.cwd()
            })
          end
        '';
      }

      {
        mode = ["n" "o" "x"];
        key = "s";
        action = ''
          function()
            require("flash").jump()
          end
        '';
      }

      {
        key = "<leader>q";
        action = ''
          function()
            vim.cmd("BufferLinePickClose")
          end
        '';
      }

      {
        key = "<leader>f";
        action = ''
          function()
            vim.cmd("Telescope")
          end
        '';
      }

      {
        key = "<leader>p";
        action = ''
          function()
            vim.cmd("TroubleToggle")
          end
        '';
      }

      {
        key = "<leader>z";
        action = ''
          function()
            vim.cmd("FormatToggle")
          end
        '';
      }
    ]
    ++ (
      map (n: {
        key = "<leader>${toString n}";
        action = ''
           function()
            vim.cmd("BufferLineGoToBuffer ${toString n}")
          end
        '';
      }) (lib.range 1 9)
    )
  );
}
