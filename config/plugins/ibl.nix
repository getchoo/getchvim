{
  plugins.indent-blankline = {
    enable = true;

    exclude.filetypes = [
      "help"
      "neo-tree"
      "Trouble"
      "lazy"
      "mason"
      "notify"
      "toggleterm"
    ];

    indent = {
      char = "│";
      tabChar = "│";
    };

    scope.enabled = false;
  };
}
