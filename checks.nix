{
  pkgs,
  self,
}: let
  inherit (pkgs) lib;
  formatter = self.formatter.${pkgs.system};
in {
  check-actionlint = pkgs.runCommand "check-actionlint" {} ''
    ${lib.getExe pkgs.actionlint} ${./.}/.github/workflows/*
    touch $out
  '';

  "check-${formatter.pname}" = pkgs.runCommand "check-${formatter.pname}" {} ''
    ${lib.getExe formatter} --check ${./.}
    touch $out
  '';

  check-selen = pkgs.runCommand "check-selene" {} ''
    ${lib.getExe pkgs.selene} ${./config}
  '';

  check-statix = pkgs.runCommand "check-statix" {} ''
    ${lib.getExe pkgs.statix} check ${./.}
    touch $out
  '';

  check-stylua = pkgs.runCommand "check-stylua" {} ''
    ${lib.getExe pkgs.stylua} --check ${./.}

    touch $out
  '';
}
