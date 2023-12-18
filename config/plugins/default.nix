{
  # import all files besides those prefixed with `_`
  imports = builtins.map (file: ./${file}) (
    builtins.filter (
      name: name != "default.nix" && (builtins.substring 0 1 name) != "_"
    ) (
      builtins.attrNames (
        builtins.readDir ./.
      )
    )
  );
}
