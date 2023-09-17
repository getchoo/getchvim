{
  perSystem = {pkgs, ...}: {
    neovim = {
      package = pkgs.neovim-unwrapped;

      paths = with pkgs; [
        # external tools
        fd
        git
        ripgrep
        just

        # lint
        actionlint
        codespell
        deadnix
        nodePackages.alex
        shellcheck
        statix

        # format
        alejandra
        beautysh
        stylua

        # lsp
        nil
        sumneko-lua-language-server
      ];

      lazy = {
        settings = {
          performance.rtp.reset = true;
          install.colorscheme = ["catppuccin"];
        };

        plugins = import ./plugins {inherit pkgs;};
      };
    };
  };
}
