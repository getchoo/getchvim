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

  check-selene = pkgs.runCommand "check-selene" {} ''
    cd ${./.}
    ${lib.getExe pkgs.selene} .
    touch $out
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
