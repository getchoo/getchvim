{ helpers, ... }:
{
  autoCmd = [
    # don't use mini.indentscope on some files
    {
      callback = helpers.mkRaw ''
        function()
          vim.b.miniindentscope_disable = true
        end
      '';
      event = "FileType";
      pattern = [
        "help"
        "Trouble"
        "toggleterm"
      ];
    }
  ];

  keymaps = [
    # open mini.files
    {
      action = helpers.mkRaw ''
        function()
          local files = require("mini.files")
        	if not files.close() then
        	  files.open()
        	end
        end
      '';

      key = "<leader>t";
      mode = "n";
      options = {
        noremap = true;
        silent = true;
      };
    }
  ];

  plugins.mini = {
    enable = true;

    modules = {
      files = { };

      hipatterns = {
        highlighters = {
          hex_color = helpers.mkRaw "require('mini.hipatterns').gen_highlighter.hex_color()";
        };
      };

      indentscope = {
        options.try_as_border = false;
      };

      pairs = { };
    };
  };
}
