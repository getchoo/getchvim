{
  plugins.indent-blankline = {
    enable = true;

    settings = {
      exclude = {
        filetypes = [
          "help"
          "Trouble"
          "toggleterm"
        ];
      };

      indent = {
        char = "│";
        tab_char = "│";
      };

      # Let mini.nvim handle this
      scope.enabled = false;
    };
  };
}
