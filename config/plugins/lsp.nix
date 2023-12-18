{lib, ...}: {
  plugins.lsp = {
    enable = true;

    capabilities = ''
      capabilities = vim.tbl_deep_extend(
        "force",
        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        { workspace = { didChangeWatchedFiles = { dynamicRegistration = true } } }
      )
    '';

    keymaps = {
      diagnostic = {
        "<leader>e" = "open_float";
        "[d" = "goto_prev";
        "]d" = "goto_next";
        "<leader>u" = "setloclist";
      };
    };

    servers = let
      withDefaultOpts = lib.genAttrs [
        "bashls"
        "lua-ls"
        "nil_ls"
      ] (_: {enable = true;});

      optionalOpts = {
        enable = true;
        installLanguageServer = false;
        autostart = false;
      };

      optional = lib.genAttrs [
        "clangd"
        "eslint"
        "pyright"
        "rust-analyzer"
        "tsserver"
      ] (_: optionalOpts);
    in
      withDefaultOpts
      // optional
      // {
        rust-analyzer =
          optionalOpts
          // {
            installRustc = false;
            installCargo = false;
          };
      };
  };
}
