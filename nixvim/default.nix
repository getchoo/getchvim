{
  imports = [
    ./filetypes
    ./plugins
  ];

  colorschemes.catppuccin = {
    enable = true;

    settings = {
      flavour = "mocha";

      integrations = {
        cmp = true;
        flash = true;
        gitsigns = true;
        indent_blankline = {
          enabled = true;
        };
        lsp_trouble = true;
        native_lsp = {
          enabled = true;
        };
        neotree = true;
        treesitter = true;
        telescope = true;
        which_key = true;
      };

      no_italic = true;
    };
  };

  globals = {
    mapleader = " ";
  };

  opts = {
    shiftwidth = 2;
    tabstop = 2;

    # line stuff
    number = true;
    wrap = true;

    # ui
    mouse = "a";
    showmode = false; # status line does this
  };
}
