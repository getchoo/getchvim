{
  plugins.lsp = {
    enable = true;

    # nil-ls wants dynamicRegistration
    capabilities = ''
      capabilities = vim.tbl_deep_extend(
       	"force",
       	vim.lsp.protocol.make_client_capabilities(),
       	require("cmp_nvim_lsp").default_capabilities(),
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

      lspBuf = {
        "<leader>ca" = "code_action";
      };
    };

    servers = let
      enable = {enable = true;};

      optional =
        enable
        // {
          installLanguageServer = false;
          autostart = false;
        };
    in {
      bashls = enable;
      clangd = optional;
      denols = optional;
      eslint = optional;

      lua-ls = enable;

      nil_ls =
        enable
        // {
          settings.formatting.command = ["alejandra"];
        };

      pyright = optional;
      ruff-lsp =
        optional
        // {
          # let pyright handle it
          onAttach.function = ''
            client.server_capabilities.hoverProvider = false
          '';
        };

      rust-analyzer =
        optional
        // {
          installRustc = false;
          installCargo = false;
          settings.check.command = "clippy";
        };

      tsserver = optional;
    };
  };
}
