{ pkgs, helpers, ... }:
{
  extraPackages = [
    pkgs.actionlint
    pkgs.nodePackages.alex
    pkgs.statix
  ];

  plugins.lint = {
    enable = true;

    # Run linters declared in lintersByFt
    # then alex on all files
    autoCmd.callback = helpers.mkRaw ''
      function()
        require("lint").try_lint()
      	require("lint").try_lint("alex")
      end
    '';

    lintersByFt = {
      githubaction = [ "actionlint" ];
      lua = [ "selene" ];
      nix = [ "statix" ];
    };
  };
}
