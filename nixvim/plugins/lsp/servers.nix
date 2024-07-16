{ pkgs, helpers, ... }:
{
  extraPackages = [
    # bashls
    pkgs.shellcheck
    pkgs.shfmt

    # nil-ls
    pkgs.nixfmt-rfc-style
  ];

  globals = {
    # Required for Deno's LSP
    markdown_fenced_languages = [ "ts=typescript" ];
  };

  plugins.lsp.servers = {
    astro.enable = true;
    bashls.enable = true;
    biome.enable = true;
    clangd.enable = true;
    denols.enable = true;
    eslint.enable = true;

    lua-ls = {
      enable = true;
      settings = {
        diagnostics.globals = [ "vim" ];
        runtime.version = "LuaJIT";
        workspace = {
          checkThirdParty = false;
          library = [ (helpers.mkRaw "vim.env.VIMRUNTIME") ];
        };
      };
    };

    nil-ls = {
      enable = true;

      settings = {
        formatting.command = [ "nixfmt" ];
      };
    };

    nimls.enable = true;
    pyright = {
      enable = true;

      settings = {
        # Use ruff for imports
        pyright = {
          disableOrganizeImports = true;
        };
        python.ignore = [ "*" ];
      };
    };

    ruff-lsp = {
      enable = true;

      # pyright should handle this
      onAttach.function = ''
        client.server_capabilities.hoverProvider = false
      '';
    };

    rust-analyzer = {
      enable = true;

      installCargo = false;
      installRustc = false;

      settings = {
        check.command = "clippy";
      };
    };

    tsserver.enable = true;
    typos-lsp.enable = true;
    typst-lsp.enable = true;
  };
}
