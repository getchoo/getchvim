{
  perSystem =
    { pkgs, self', ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = [
          pkgs.actionlint

          self'.formatter
          pkgs.nil
          pkgs.statix
        ];
      };
    };
}
