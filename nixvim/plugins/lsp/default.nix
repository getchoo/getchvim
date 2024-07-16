{
  imports = [
    ./keymaps.nix
    ./servers.nix
  ];

  plugins.lsp = {
    enable = true;

    capabilities = ''
      capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        -- for nil_ls
        { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
      )
    '';
  };
}
