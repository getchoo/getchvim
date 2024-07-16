{
  perSystem =
    { lib, pkgs, ... }:
    let
      root = lib.fileset.toSource {
        root = ../.;
        fileset = lib.fileset.unions [
          ./.
          ../.github
          ../nixvim
          ../flake.nix
        ];
      };
    in
    {
      checks = {
        format-and-lint =
          pkgs.runCommand "format-and-lint"
            {
              src = root;
              nativeBuildInputs = [
                pkgs.actionlint
                pkgs.deadnix
                pkgs.nixfmt-rfc-style
                pkgs.statix
              ];
            }
            ''
              echo "running actionlint..."
              actionlint ./.github/workflows/*

              echo "running deadnix..."
              deadnix

              echo "running nixfmt..."
              nixfmt --check .

              echo "running statix..."
              statix check .

              touch $out
            '';
      };
    };
}
