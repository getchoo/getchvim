{
  keymaps = [
    {
      action = "FormatToggle";
      key = "<leader>z";
      mode = "n";
      options = {
        noremap = true;
        silent = true;
      };
    }
  ];

  plugins.lsp-format = {
    enable = true;
  };
}
