{
  plugins.mini = {
    enable = true;

    modules = {
      comment = {};
      pairs = {};
      indentscope = {
        options.try_as_border = true;
      };
    };
  };

  autoCmd = [
    {
      event = ["FileType"];
      pattern = [
        "help"
        "neo-tree"
        "Trouble"
        "lazy"
        "mason"
        "notify"
        "toggleterm"
      ];

      callback = {
        __raw = ''
          function()
            vim.b.miniindentscope_disable = true
          end
        '';
      };
    }
  ];
}
