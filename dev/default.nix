{
  imports = [
    ./checks.nix
    ./devShell.nix
  ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-rfc-style;
    };
}
