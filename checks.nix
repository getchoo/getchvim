{
  pkgs,
  self,
}: let
  inherit (pkgs) lib;
  formatter = self.formatter.${pkgs.system};
in {
  check-actionlint =
    pkgs.runCommand "check-actionlint" {
      nativeBuildInputs = [pkgs.actionlint];
    } ''
      actionlint ${./.}/.github/workflows/*
      touch $out
    '';

  "check-${formatter.pname}" =
    pkgs.runCommand "check-${formatter.pname}" {
      nativeBuildInputs = [formatter];
    } ''
      ${lib.getExe formatter} --check ${./.}
      touch $out
    '';

  check-statix =
    pkgs.runCommand "check-statix" {
      nativeBuildInputs = [pkgs.statix];
    }
    ''
      statix check ${./.}
      touch $out
    '';

  check-nil =
    pkgs.runCommand "check-nil" {
      nativeBuildInputs = with pkgs; [fd git nil];
    }
    ''
      cd ${./.}
      fd . -e 'nix' | while read -r file; do
        nil diagnostics "$file"
      done

      touch $out
    '';

  check-stylua = pkgs.runCommand "check-stylua" {} ''
    ${lib.getExe pkgs.stylua} --check ${./.}

    touch $out
  '';
}
