{pkgs, ...}: {
  imports = [
    ./plugins
    ./keymaps.nix
  ];

  config = {
    clipboard.providers.wl-copy.enable = pkgs.stdenv.isLinux;

    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";

      disableItalic = true;
    };

    enableMan = false;

    globals = {
      mapleader = ",";
    };

    options = {
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      wrap = true;
      syntax = "on";
      termguicolors = true;
    };
  };
}
