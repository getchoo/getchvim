{
  plugins.bufferline = {
    enable = true;

    alwaysShowBufferline = false;
    diagnostics = "nvim_lsp";
    mode = "buffers";
    numbers = "ordinal";
    separatorStyle = "slant";
    offsets = [
      {
        filetype = "neo-tree";
        text = "neo-tree";
        highlight = "Directory";
        text_align = "left";
      }
    ];
  };
}
