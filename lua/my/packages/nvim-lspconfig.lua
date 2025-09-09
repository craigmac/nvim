-- https://github.com/neovim/nvim-lspconfig
-- using new way for 0.11.4
-- here in case I try to run this on nvim 0.10.4 on debian stable (13)
if vim.version.le(vim.version(), { 0, 11, 0 }) then
  vim.notify('nvim-lspconfig.lua requires 0.11.0 nvim')
  return
end

-- vim.lsp.enable('lua_ls')

