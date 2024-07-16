{
  keymaps = [
    {
      action = "Trouble diagnostics toggle";
      key = "<leader>p";
      mode = "n";
      options = {
        noremap = true;
        silent = true;
      };
    }
  ];

  plugins.trouble = {
    enable = true;
  };
}
