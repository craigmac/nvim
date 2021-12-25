local status_ok, _ = pcall(require, "nvim-lspconfig")
if not status_ok then
  return
end

require "my.lsp-installer"
require("my.handlers").setup()
require "my.null-ls"
