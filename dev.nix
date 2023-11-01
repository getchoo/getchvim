{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      shellHook = config.pre-commit.installationScript;

      packages = with pkgs; [
        actionlint
        alejandra
        deadnix
        nil
        statix
        stylua
      ];
    };

    formatter = pkgs.alejandra;

    pre-commit.settings.hooks = {
      actionlint.enable = true;
      alejandra.enable = true;
      deadnix.enable = true;
      nil.enable = true;
      statix.enable = true;
      stylua.enable = true;
    };
  };
}
