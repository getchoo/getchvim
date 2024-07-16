{
  plugins.lsp.keymaps = {
    silent = true;

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
}
