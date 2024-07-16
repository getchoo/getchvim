{ helpers, ... }:
{
  keymaps = [
    {
      action = helpers.mkRaw ''
        function()
          require("flash").jump()
        end
      '';

      key = "s";

      options = {
        noremap = true;
        silent = true;
      };

      mode = [
        "n"
        "o"
        "x"
      ];
    }
  ];

  plugins.flash = {
    enable = true;
  };
}
