{
  keymaps = [
    {
      action = "Telescope";
      key = "<leader>f";
      mode = "n";
      options = {
        noremap = true;
        silent = true;
      };
    }
  ];

  plugins.telescope = {
    enable = true;
  };
}
